import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/Banner_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/data/model/Recent_song_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/provider/Artist_api_provider.dart';
import 'package:sq_mp3/data/provider/Banner_api_provider.dart';
import 'package:sq_mp3/data/provider/Playlist_api_provider.dart';
import 'package:sq_mp3/data/provider/Recent_song_api.dart';
import 'package:sq_mp3/data/provider/RecommentSong_api_provider.dart';
import 'package:sq_mp3/data/provider/Song_api_provider.dart';
import 'package:sq_mp3/data/provider/User_api_provider.dart';
import 'package:sq_mp3/modules/profile/controller/Profile_controller.dart';

class HomeController extends GetxController {
  final currentindex = 0.obs;

  final TokenService tokenService = TokenService();
  final PlaylistProvider playlistProvider = PlaylistProvider();
  final ArtistApiProvider artistProvider = ArtistApiProvider();
  final RecommentSongApiProvider recommentSongApiProvider =
      RecommentSongApiProvider();
  final BannerApiProvider bannerApiProvider = BannerApiProvider();
  final RecentSongApiProvider recentSongApiProvider = RecentSongApiProvider();
  final UserApiProvider userApiProvider = UserApiProvider();

  RxBool loading = true.obs;
  RxString userName = "".obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<SongItemModel> recommendSongs = <SongItemModel>[].obs;
  RxList<RecentSongModel> recentSongs = <RecentSongModel>[].obs;
  RxList<PlaylistModel> playlists = <PlaylistModel>[].obs;
  RxList<AlbumModel> albums = <AlbumModel>[].obs;
  RxList<ArtistModel> artists = <ArtistModel>[].obs;
  RxList<SongItemModel> songOfPlaylistSystem = <SongItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHome();
  }

  Future<void> loadHome() async {
    loading.value = true;

    try {
      final token = await tokenService.getToken();
      print("TOKEN = $token");

      if (token != null) {
        final songs = await recommentSongApiProvider.getRecommendSongs(token);
        print("Songs: ${songs.length}");

        final banners = await bannerApiProvider.getAllBanner(token);
        print("Banners: ${banners.length}");

        final playlists = await playlistProvider.getPlaylistHome(token);
        print("Playlists: ${playlists.length}");

        final artists = await artistProvider.getAllArtists(token);
        print("Artists: ${artists.length}");

        final recentSong = await recentSongApiProvider.getRecentHistory(token);
        print("Recent song: ${recentSong.length}");

        final user = await userApiProvider.getMyProfile();

        recommendSongs.assignAll(songs);
        this.banners.assignAll(banners);
        this.playlists.assignAll(playlists);
        this.artists.assignAll(artists);
        this.recentSongs.assignAll(recentSong);
        this.userName.value = user.name;
      }
    } catch (e, s) {
      print(e);
      print(s);
    } finally {
      loading.value = false;
    }
  }

  Future<void> addToRecentHistory(
    String songId,
    int duration,
    String source,
  ) async {
    try {
      await recentSongApiProvider.addToRecentHistory(songId, duration, source);

      // Refresh the recent songs list after adding
      final token = await tokenService.getToken();
      if (token != null) {
        final recentSong = await recentSongApiProvider.getRecentHistory(token);
        recentSongs.assignAll(recentSong);
      }
    } catch (e) {
      print("Error adding to recent history: $e");
    }
  }

  Future<void> deleteSongInHistory(String id) async {
    try {
      final token = await tokenService.getToken();
      if (token == null) {
        Get.snackbar("Lỗi", "bạn chưa đăng nhập!");
        return;
      }
      final result = await recentSongApiProvider.deleteSongInListenHistory(
        token,
        id,
      );

      if (result.isNotEmpty) {
        recentSongs.removeWhere((e) => e.id == id);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAllSongInHistory() async {
    try {
      final token = await tokenService.getToken();
      if (token == null) {
        Get.snackbar("Lỗi", "bạn chưa đăng nhập!");
        return;
      }
      final result = await recentSongApiProvider.deleteAll(token);

      if (result.isNotEmpty) {
        recentSongs.clear();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


}
