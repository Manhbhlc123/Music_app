import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/Download_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/provider/Album_api_provider.dart';
import 'package:sq_mp3/data/provider/Download_api_provider.dart';
import 'package:sq_mp3/data/provider/Favorite_api_provider.dart';
import 'package:sq_mp3/data/provider/Follow_api_provider.dart';
import 'package:sq_mp3/data/provider/Playlist_api_provider.dart';
import 'package:sq_mp3/data/provider/Song_api_provider.dart';
import 'package:sq_mp3/modules/library/view/Album_view.dart';

class LibraryController extends GetxController {
  final TokenService tokenService = TokenService();
  final DownloadApiProvider downloadApiProvider = DownloadApiProvider();
  final FollowApiProvide followApiProvide = FollowApiProvide();
  final AlbumApiProvider albumApiProvider = AlbumApiProvider();
  final PlaylistProvider playlistProvider = PlaylistProvider();

  RxList<AlbumModel> albums = <AlbumModel>[].obs;
  RxList<PlaylistModel> playlists = <PlaylistModel>[].obs;
  RxList<DownloadModel> downloads = <DownloadModel>[].obs;
  RxList<ArtistModel> followedArtist = <ArtistModel>[].obs;
  RxList<SongItemModel> songOfAlbum = <SongItemModel>[].obs;
  // RxList<SongItemModel> songOfPlaylist = <SongItemModel>[].obs;
  RxInt remainingDownloads = 0.obs;

  Future<void> loadDownloadPage() async {
    final token = await tokenService.getToken();

    try {
      if (token != null) {
        List<DownloadModel> download = await downloadApiProvider
            .getDownloadSong(token);

        downloads.assignAll(download);
      }
    } catch (e) {
      print("Error loading downloads: $e");
    }
  }

  Future<void> getRemainingDownload() async {
    final token = await tokenService.getToken();

    try {
      if (token != null) {
        int remaining = await downloadApiProvider.getRemainingDownloads(token);
        remainingDownloads.value = remaining;
        print("remainingDownloads.value = ${remainingDownloads.value}");
      }
    } catch (e) {
      print("Error fetching remaining downloads: $e");
    }
  }

  Future<void> loadFollowedArtistPage() async {
    final token = await tokenService.getToken();

    try {
      if (token != null) {
        List<ArtistModel> artists = await followApiProvide.getFollowedArtist(
          token,
        );

        followedArtist.assignAll(artists);
      }
    } catch (e) {
      print("Error loading followed artist: $e");
    }
  }

  Future<void> toggleFollowArtist(ArtistModel artist) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        Get.snackbar("Lỗi", "Bạn chưa đăng nhập");
        return;
      }

      final isFollowing = await followApiProvide.followArtist(token, artist.id);

      if (isFollowing) {
        // Đã follow
        Get.snackbar("Thành công", "Đã theo dõi ${artist.name}");
      } else {
        // Đã unfollow
        followedArtist.removeWhere((item) => item.id == artist.id);

        Get.snackbar("Thành công", "Đã bỏ theo dõi ${artist.name}");
      }
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
    }
  }

  Future<void> loadAlbumPage() async {
    try {
      final token = await tokenService.getToken();
      if (token == null) {
        Get.snackbar("Lỗi", "Bạn chưa đăng nhập");
      } else {
        List<AlbumModel> albums2 = await albumApiProvider.getAlbum(token);
        albums.assignAll(albums2);
      }
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
    }
  }

  Future<void> removeAlbum() async {}

  Future<void> loadPlaylistPage() async {
    try {
      final token = await tokenService.getToken();
      if (token == null) {
        Get.snackbar("Lỗi", "Bạn chưa đăng nhập");
      } else {
        List<PlaylistModel> playlists2 = await playlistProvider
            .getUserPlaylists(token);
        playlists.assignAll(playlists2);
        print(playlists2.length);
      }
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
    }
  }

  Future<void> loadSongOfAlbum(String albumId) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        Get.snackbar("Lỗi", "Bạn chưa đăng nhập");
      } else {
        List<SongItemModel> songs = await albumApiProvider.getSongOfAlbum(
          token,
          albumId,
        );

        songOfAlbum.assignAll(songs);
      }
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
    }
  }

  Future<void> removePlaylist(String playlistId) async {
    try {
      final token = await tokenService.getToken();

      if (token == null) {
        Get.snackbar("Lỗi", "Bạn chưa đăng nhập");
      } else {
        final result = await playlistProvider.deletePlaylist(token, playlistId);
        if (!result.isEmpty) {
          playlists.removeWhere((e) => e.id == playlistId);
        } else {
          return;
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
