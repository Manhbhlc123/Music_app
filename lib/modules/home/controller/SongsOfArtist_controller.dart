import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/provider/Follow_api_provider.dart';
import 'package:sq_mp3/data/provider/Song_api_provider.dart';

class SongsOfArtistController extends GetxController {
  final TokenService tokenService = TokenService();
  final SongApiProvider songApiProvider = SongApiProvider();
  final FollowApiProvide followApiProvide = FollowApiProvide();

  final songs = <SongItemModel>[].obs;
  final isLoading = false.obs;
  final checkState = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null &&
        Get.arguments is Map &&
        Get.arguments['artistId'] != null) {
      getState(Get.arguments['artistId']);
      loadSongs(Get.arguments['artistId']);
    }
  }

  Future<void> loadSongs(String artistId) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      print("TOKEN ARTIST = $token");

      if (token == null) {
        throw Exception("Token is null");
      }

      final result = await songApiProvider.getSongsOfArtist(artistId, token);

      songs.assignAll(result);
    } catch (e) {
      print("Load songs artist error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //follow artist
  Future<void> followArtist() async {
    try {
      final artistId = Get.arguments['artistId'];
      if (artistId == null) return;

      final token = await tokenService.getToken();
      if (token == null) {
        throw Exception("Token is null");
      }

      final result = await followApiProvide.followArtist(token, artistId);
      if (result) {
        String message = checkState.value ? "Unfollowed artist successfully" : "Followed artist successfully";
        checkState.value = !checkState.value;
        Get.snackbar("Success", message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  //check current state
  Future<void> getState(String artistId) async {
    try {
      final token = await tokenService.getToken();
      if (token == null) {
        throw Exception("Token is null");
      }

      final result = await followApiProvide.checkState(token, artistId);
      checkState.value = result ?? false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
