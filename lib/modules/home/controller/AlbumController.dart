import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/provider/Album_api_provider.dart';

class AlbumController extends GetxController {
  final TokenService tokenService = TokenService();
  final AlbumApiProvider albumApiProvider = AlbumApiProvider();

  Future<bool> addSongToAlbum(String albumId, String songId) async {
    try {
      final token = await tokenService.getToken();

      if (token == null || token.isEmpty) {
        Get.snackbar("Lỗi", "Bạn chưa đăng nhập");
        return false;
      }

      final result = await albumApiProvider.addSongToAlbum(
        token,
        albumId,
        songId,
      );

      print("Backend message: $result");

      Get.snackbar(
        "Thành công",
        "Đã thêm bài hát vào album",
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      print("Controller error: $e");

      Get.snackbar("Lỗi", e.toString(), snackPosition: SnackPosition.BOTTOM);

      return false;
    }
  }
  //delete
  Future<void> deleteAlbum(String albumId) async {
    try {
      final token = await tokenService.getToken();
      if (token == null || token.isEmpty) {
        Get.snackbar("Lỗi", "Bạn chưa đăng nhập");
        return;
      }

      final result = await albumApiProvider.removeAlbum(token, albumId);
      if (result.isNotEmpty) {
        Get.snackbar("Thành công", "Đã xóa album khỏi thư viện",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Lỗi", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Future<bool> removeSongFromAlbum(String albumId, String songId) async {
  //   try {
  //     final token = await tokenService.getToken();
  //
  //     if (token == null || token.isEmpty) {
  //       Get.snackbar("Lỗi", "Bạn chưa đăng nhập");
  //       return false;
  //     }
  //
  //     await albumApiProvider.removeSongFromAlbum(token, albumId, songId);
  //
  //     Get.snackbar(
  //       "Thành công",
  //       "Đã xóa bài hát khỏi album",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return true;
  //   } catch (e) {
  //     Get.snackbar("Lỗi", e.toString(), snackPosition: SnackPosition.BOTTOM);
  //     return false;
  //   }
  // }
}
