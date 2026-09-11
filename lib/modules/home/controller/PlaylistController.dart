import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/provider/Playlist_api_provider.dart';

class PlaylistController extends GetxController {
  final TokenService tokenService = TokenService();
  final PlaylistProvider playlistProvider = PlaylistProvider();

  Future<bool> addSongToPlaylist(
      String playlistId,
      String songId,
      ) async {
    try {
      final token = await tokenService.getToken();

      if (token == null || token.isEmpty) {
        Get.snackbar(
          "Lỗi",
          "Bạn chưa đăng nhập",
        );
        return false;
      }

      final result =
      await playlistProvider.addSongToPlaylist(
        token,
        songId,
        playlistId,
      );

      print("Backend message: $result");

      Get.snackbar(
        "Thành công",
        "Đã thêm bài hát vào playlist",
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;

    } catch (e) {
      print("Controller error: $e");

      Get.snackbar(
        "Lỗi",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }
  }
}
