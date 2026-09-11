
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/Favorite_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/provider/Favorite_api_provider.dart';

class FavoriteController extends GetxController {
  RxBool loading = false.obs;
  RxList<SongItemModel> favoriteSongs = <SongItemModel>[].obs;


  final TokenService tokenService = TokenService();
  final FavoriteApiProvider favoriteApiProvider = FavoriteApiProvider();

@override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    loading.value = true;
    try {
      final token = await tokenService.getToken();
      if (token != null) {
        final songs = await favoriteApiProvider.getAllFavorites(token);

        favoriteSongs.assignAll(songs);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load favorites');
    } finally {
      loading.value = false;
    }
  }

  Future<void> toggleFavorite(SongItemModel song) async {
    try {
      final token = await tokenService.getToken();

      if (token == null || token.isEmpty) {
        Get.snackbar(
          'Error',
          'Please login to add favorites',
        );
        return;
      }

      final isFavoriteNow =
      await favoriteApiProvider.toggleFavorite(
        token,
        song.id,
      );

      if (isFavoriteNow) {
        // BE báo đã favorite
        if (!favoriteSongs.any((item) => item.id == song.id)) {
          favoriteSongs.add(song);
        }
      } else {
        // BE báo đã bỏ favorite
        favoriteSongs.removeWhere(
              (item) => item.id == song.id,
        );
      }

      favoriteSongs.refresh();

      print(
        "Song ${song.id} favorite = $isFavoriteNow",
      );
    } catch (e) {
      print("Toggle favorite error: $e");

      Get.snackbar(
        'Error',
        'Failed to update favorite',
      );
    }
  }

  bool isFavorite(String songId) {
    return favoriteSongs.any((song) => song.id == songId);
  }
}
