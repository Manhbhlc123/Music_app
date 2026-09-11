import 'dart:math';

import 'package:get/get.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class QueueController extends GetxController {
  final Rxn<SongItemModel> currentSong = Rxn<SongItemModel>();

  final RxList<SongItemModel> queue = <SongItemModel>[].obs;

  final currentIndex = 0.obs;

  //add song to queue
  void addToQueue(SongItemModel song) {
    queue.add(song);
  }

  void removeFromQueue(int index) {
    if (index >= 0 && index < queue.length) {
      queue.removeAt(index);
      if (index < currentIndex.value) {
        currentIndex.value--;
      }
    }
  }

  void clearQueue() {
    queue.clear();
    currentIndex.value = 0;
    currentSong.value = null;
  }

  // add all song to queue
  void addAllSongToQueue(List<SongItemModel> songs) {
    queue.addAll(songs);
  }

  //next song
  SongItemModel? nextSong() {
    if (queue.isEmpty) {
      return null;
    }
    if (currentIndex.value + 1 >= queue.length) {
      return null;
    }

    currentIndex.value++;

    final song = queue[currentIndex.value];

    currentSong.value = song;

    return song;
  }

  //previous song
  SongItemModel? previousSong() {
    if (queue.isEmpty || currentIndex.value <= 0) {
      return null;
    }

    currentIndex.value--;

    final song = queue[currentIndex.value];

    currentSong.value = song;

    return song;
  }

  void playNow(SongItemModel song) {
    final index = queue.indexWhere((item) => item.id == song.id);

    if (index != -1) {
      currentIndex.value = index;
    } else {
      queue.insert(0, song);
      currentIndex.value = 0;
    }

    currentSong.value = song;
  }

  void playPlaylist(List<SongItemModel> songs, int index) {
    queue.assignAll(songs);
    if (index >= 0 && index < queue.length) {
      currentIndex.value = index;
      currentSong.value = queue[index];
    } else {
      currentIndex.value = 0;
      currentSong.value = queue.isNotEmpty ? queue[0] : null;
    }
  }


  //random song
  SongItemModel? randomSong()
  {
    if(queue.isEmpty)
      {
        return null;
      }

    //chỉ có 1 bài
    if(queue.length == 1)
      {
        currentIndex.value = 0;
        currentSong.value = queue[0];
        return queue[0];
      }

    final random = Random();

    int randomIndex;

    //chọn bài hiện tại
    do{
      randomIndex = random.nextInt(queue.length);
    }while(randomIndex == currentIndex.value);

    currentIndex.value = randomIndex;

    final song = queue[currentIndex.value];

    currentSong.value = song;

    return song;

  }

  void addNext(SongItemModel song)
  {
    final nextIndex = currentIndex.value + 1;
    if(nextIndex >= queue.length)
      {
        queue.add(song);
      }else
        {
          queue.insert(nextIndex, song);
        }
  }
}
