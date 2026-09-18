import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/createRequest/AlbumCreate_request.dart';
import 'package:sq_mp3/data/createRequest/ArtistCreate_request.dart';
import 'package:sq_mp3/data/createRequest/GenreCreate_request.dart';
import 'package:sq_mp3/data/createRequest/PlaylistCreate_request.dart';
import 'package:sq_mp3/data/createRequest/SongCreate_request.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/model/User_model.dart';
import 'package:sq_mp3/data/model/genre_model.dart';
import 'package:sq_mp3/data/provider/Album_api_provider.dart';
import 'package:sq_mp3/data/provider/Artist_api_provider.dart';
import 'package:sq_mp3/data/provider/Genres_api_provider.dart';
import 'package:sq_mp3/data/provider/Playlist_api_provider.dart';
import 'package:sq_mp3/data/provider/Song_api_provider.dart';
import 'package:sq_mp3/data/provider/User_api_provider.dart';

class AdminController extends GetxController {
  final UserApiProvider _userApiProvider = Get.find<UserApiProvider>();
  final SongApiProvider _songApiProvider = Get.find<SongApiProvider>();
  final PlaylistProvider _playlistProvider = Get.find<PlaylistProvider>();
  final AlbumApiProvider _albumApiProvider = Get.find<AlbumApiProvider>();
  final ArtistApiProvider _artistApiProvider = Get.find<ArtistApiProvider>();
  final GenresApiProvider _genreApiProvider = Get.find<GenresApiProvider>();
  final tokenService = TokenService();

  var userCount = 0.obs;
  var songCount = 0.obs;
  var playlistCount = 0.obs;
  var albumCount = 0.obs;
  var artistCount = 0.obs;
  var genreCount = 0.obs;
  var isLoading = false.obs;

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<SongItemModel> songs = <SongItemModel>[].obs;
  final RxList<AlbumModel> albums = <AlbumModel>[].obs;
  final RxList<PlaylistModel> playlists = <PlaylistModel>[].obs;
  final RxList<ArtistModel> artists = <ArtistModel>[].obs;
  final RxList<GenresModel> genres = <GenresModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdminData();
  }

  Future<void> fetchAdminData() async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();
      if (token == null) {
        return;
      }

      final user_count = await _userApiProvider.getUserCount(token);
      userCount.value = user_count;

      final song_count = await _songApiProvider.getSongCount(token);
      songCount.value = song_count;

      final playlist_count = await _playlistProvider.getPlaylistCount(token);
      playlistCount.value = playlist_count;

      final album_count = await _albumApiProvider.getAlbumCount(token);
      albumCount.value = album_count;

      final artist_count = await _artistApiProvider.getArtistCount(token);
      artistCount.value = artist_count;

      final genre_count = await _genreApiProvider.getGenreCount(token);
      genreCount.value = genre_count;

      users.clear();
      final userList = await _userApiProvider.getAllUsers(token);
      users.assignAll(userList);

      songs.clear();
      final songList = await _songApiProvider.getAllSong(token);
      songs.assignAll(songList);

      final albumList = await _albumApiProvider.getAlbum(token);
      albums.assignAll(albumList);

      final playlistList = await _playlistProvider.getAllPlaylist(token);
      playlists.assignAll(playlistList);

      final artistList = await _artistApiProvider.getAllArtists(token);
      artists.assignAll(artistList);

      final genresList = await _genreApiProvider.getAllGenres(token);
      genres.assignAll(genresList);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //user
  Future<void> deleteUser(String userId) async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _userApiProvider.deleteUser(userId, token);

      if (result.isNotEmpty) {
        Get.snackbar("Success", "User deleted successfully");
        users.removeWhere((user) => user.id == userId);
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _userApiProvider.updateUser(user, token);

      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "User updated successfully");

        final index = users.indexWhere((u) => u.id == result.id);

        if (index != -1) {
          users[index] = result;
          users.refresh();
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //song
  Future<void> deleteSong(String songId) async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _songApiProvider.deleteSong(token, songId);

      if (result.isNotEmpty) {
        Get.snackbar("Success", "Song deleted successfully");
        songs.removeWhere((song) => song.id == songId);
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSong(SongItemModel song) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _songApiProvider.updateSong(song, token);

      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "Song updated successfully");

        final index = songs.indexWhere((s) => s.id == result.id);

        if (index != -1) {
          songs[index] = result;
          songs.refresh();
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createSong(SongCreateRequest request) async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();
      if (token == null) {
        return;
      }
      final result = await _songApiProvider.createSong(token, request);
      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "Song created successfully");
        songs.add(result);
        songs.refresh();
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //album
  Future<void> deleteAlbum(String albumId) async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _albumApiProvider.removeAlbum(token, albumId);

      if (result.isNotEmpty) {
        Get.snackbar("Success", "Album deleted successfully");
        albums.removeWhere((album) => album.id == albumId);
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAlbum(AlbumModel album) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _albumApiProvider.updateAlbum(album, token);

      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "Album updated successfully");

        final index = albums.indexWhere((a) => a.id == result.id);

        if (index != -1) {
          albums[index] = result;
          albums.refresh();
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createAlbum(AlbumCreateRequest request) async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();
      if (token == null) {
        return;
      }
      final result = await _albumApiProvider.createAlbum(token, request);
      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "Album created successfully");
        albums.add(result);
        albums.refresh();
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //playlist
  Future<void> deletePlaylist(String playlistId) async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _playlistProvider.deletePlaylist(token, playlistId);

      if (result.isNotEmpty) {
        Get.snackbar("Success", "Playlist deleted successfully");
        playlists.removeWhere((playlist) => playlist.id == playlistId);
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePlaylist(PlaylistModel playlist) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _playlistProvider.updatePlaylist(token, playlist);

      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "Playlist updated successfully");

        final index = playlists.indexWhere((p) => p.id == result.id);

        if (index != -1) {
          playlists[index] = result;
          playlists.refresh();
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPlaylist(PlaylistCreateRequest request) async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();
      if (token == null) {
        return;
      }
      final result = await _playlistProvider.createPlaylist(token, request);
      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "Playlist created successfully");
        playlists.add(result);
        playlists.refresh();
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //artist
  Future<void> deleteArtist(String artistId) async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _artistApiProvider.deleteArtist(token, artistId);

      if (result.isNotEmpty) {
        Get.snackbar("Success", "Artist deleted successfully");
        artists.removeWhere((artist) => artist.id == artistId);
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateArtist(ArtistModel artist) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _artistApiProvider.updateArtist(token, artist);

      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "Artist updated successfully");

        final index = artists.indexWhere((a) => a.id == result.id);

        if (index != -1) {
          artists[index] = result;
          artists.refresh();
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createArtist(ArtistCreateRequest request) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _artistApiProvider.createArtist(token, request);

      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "Artist created successfully");
        artists.add(result);
        artists.refresh();
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //genres
  Future<void> updateGenre(GenresModel genre) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _genreApiProvider.updateGenre(token, genre);

      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "genre updated successfully");

        final index = genres.indexWhere((g) => g.id == result.id);

        if (index != -1) {
          genres[index] = result;
          genres.refresh();
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteGenre(String genreId) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _genreApiProvider.deleteGenre(token, genreId);

      if (result.isNotEmpty) {
        Get.snackbar("Success", "genre deleted successfully");
        genres.removeWhere((g) => g.id == genreId);
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createGenre(GenreCreateRequest request) async {
    try {
      isLoading.value = true;

      final token = await tokenService.getToken();

      if (token == null) {
        return;
      }

      final result = await _genreApiProvider.createGenre(token, request);

      if (result.id.isNotEmpty) {
        Get.snackbar("Success", "genre created successfully");
        genres.add(result);
        genres.refresh();
        fetchAdminData();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void refreshData() {
    fetchAdminData();
  }
}
