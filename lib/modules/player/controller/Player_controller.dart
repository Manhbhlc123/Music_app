import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/LyricLine_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/provider/Recent_song_api.dart';
import 'package:sq_mp3/data/provider/SongLyric_api_provider.dart';
import 'package:sq_mp3/data/provider/Song_api_provider.dart';
import 'package:sq_mp3/modules/player/controller/Queue_controller.dart';

enum RepeatMode { none, all, one }

class PlayerController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  final SongLyricApiProvider songLyricApiProvider = SongLyricApiProvider();
  final tokenService = TokenService();
  final songApiProvide = SongApiProvider();

  final QueueController queueController = Get.find<QueueController>();
  Rxn<SongItemModel> currentSong = Rxn<SongItemModel>();
  RxList<LyricLineModel> lyrics = <LyricLineModel>[].obs;
  RxBool isPLaying = false.obs;
  RxBool isLoading = false.obs;
  RxInt currentLyricIndex = (-1).obs;
  RxBool isShuffle = false.obs;
  final repeatMode = RepeatMode.none.obs;

  Future<void> _playerOperation = Future.value();

  @override
  void onInit() {
    super.onInit();
    player.playerStateStream.listen((state) {
      isPLaying.value = state.playing;

      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });

    player.positionStream.listen((position) {
      updateCurrentLyrics(position);
    });
  }

  Future<void> playSong(SongItemModel song) {
    _playerOperation = _playerOperation.then((_) async {
      try {
        isLoading.value = true;

        currentSong.value = song;
        currentLyricIndex.value = -1;
        lyrics.clear();

        final index = queueController.queue.indexWhere(
          (item) => item.id == song.id,
        );

        if (index != -1) {
          queueController.currentIndex.value = index;
        } else {
          queueController.queue.add(song);

          queueController.currentIndex.value = queueController.queue.length - 1;
        }

        await player.stop();

        await player.setUrl(song.audioUrlNormal);

        player.play();

        loadLyrics(song.id).catchError((e) {
          print("Lỗi lyrics: $e");
        });
      } catch (e, s) {
        print("Lỗi playSong(${song.title}): $e");
        print(s);
      } finally {
        isLoading.value = false;
      }
    });

    return _playerOperation;
  }

  //seek
  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  //pause
  Future<void> pause() async {
    await player.pause();
  }

  //resume
  Future<void> resume() async {
    await player.play();
  }

  //stop
  Future<void> stop() async {
    await player.stop();
  }

  //play next
  Future<void> playNext() async {
    if (queueController.queue.isEmpty) {
      return;
    }

    //repeat 1 song
    if (repeatMode.value == RepeatMode.one) {
      await player.seek(Duration.zero);
      await player.play();
      repeatMode.value = RepeatMode.none;
      return;
    }

    SongItemModel? nextSong;

    if (isShuffle.value) {
      nextSong = queueController.randomSong();
    } else {
      nextSong = queueController.nextSong();
    }

    if (nextSong == null) {
      if (repeatMode.value == RepeatMode.all) {
        queueController.currentIndex.value = 0;
        nextSong = queueController.queue.first;
        currentSong.value = nextSong;
      } else {
        return;
      }
    }

    await playSong(nextSong);
  }

  //bài trước
  Future<void> playPrevious() async {
    //nếu chạy quá 3s thì chạy về đầu bài
    if (player.position.inSeconds > 3) {
      await player.seek(Duration.zero);
      return;
    }

    final previousSong = queueController.previousSong();

    if (previousSong == null) {
      return;
    }
    await playSong(previousSong);
  }

  //ngẫu nhiên
  void toggleShuffle() {
    isShuffle.value = !isShuffle.value;
  }

  //repeat
  void toggleRepeat() {
    switch (repeatMode.value) {
      case RepeatMode.none:
        repeatMode.value = RepeatMode.all;
        break;
      case RepeatMode.all:
        repeatMode.value = RepeatMode.one;
        break;
      case RepeatMode.one:
        repeatMode.value = RepeatMode.none;
        break;
    }
  }

  //load lyrics
  Future<void> loadLyrics(String songId) async {
    try {
      final response = await songLyricApiProvider.getLyrics(songId);

      if (currentSong.value!.id != songId) {
        return;
      }

      lyrics.assignAll(response.lyrics);
    } catch (e) {
      print(e.toString());
      lyrics.clear();
    }
  }

  //update current lyrics
  void updateCurrentLyrics(Duration position) {
    final currentMs = position.inMilliseconds;

    final index = lyrics.indexWhere(
      (lyric) => currentMs >= lyric.timeStart && currentMs < lyric.timeEnd,
    );

    if (index != -1 && index != currentLyricIndex.value) {
      currentLyricIndex.value = index;
    }
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
