import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/provider/Playlist_api_provider.dart';
import 'package:sq_mp3/data/provider/Song_api_provider.dart';

class PlaylistDetailController extends GetxController {
  final TokenService tokenService = TokenService();
  final PlaylistProvider playlistProvider = PlaylistProvider();
  final SongApiProvider songApiProvider = SongApiProvider();


  final songOfPlaylistSystem = <SongItemModel>[].obs;
  final isLoading = false.obs;
  final playlistName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map) {
      playlistName.value = Get.arguments['playlistName'] ?? '';
      if (Get.arguments['playlistId'] != null) {
        getSongOfPlaylist(Get.arguments['playlistId']);
      }
    }
  }

  /// Get songs of a specific system playlist
  Future<void> getSongOfPlaylist(String playlistId) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token != null) {
        final songs = await playlistProvider.getSongOfPlaylistSystem(
          token,
          playlistId,
        );

        songOfPlaylistSystem.assignAll(songs);

        print("get song of playlist successful");
      }
    } catch (e, s) {
      print(e.toString());
      print(s.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //delete song
  Future<void> deleteSong(String songId) async {
    try {
      final token = await tokenService.getToken();
      if(token == null)
      {
        Get.snackbar("Lỗi", "Bạn chưa đăng nhập");
      }else{
        final result = await songApiProvider.deleteSong(token, songId);
        if(result.isEmpty)
        {
          return;
        }else{
          songOfPlaylistSystem.removeWhere((e) => e.id == songId);
          Get.snackbar("Thành công", "Đã xóa bài hát khỏi danh sách");
        }
      }
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
    }
  }
}
