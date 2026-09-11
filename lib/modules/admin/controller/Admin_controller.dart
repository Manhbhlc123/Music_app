import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/model/User_model.dart';
import 'package:sq_mp3/data/provider/Album_api_provider.dart';
import 'package:sq_mp3/data/provider/Playlist_api_provider.dart';
import 'package:sq_mp3/data/provider/Song_api_provider.dart';
import 'package:sq_mp3/data/provider/User_api_provider.dart';

class AdminController extends GetxController
{
  final UserApiProvider _userApiProvider = Get.find<UserApiProvider>();
  final SongApiProvider _songApiProvider = Get.find<SongApiProvider>();
  final PlaylistProvider _playlistProvider = Get.find<PlaylistProvider>();
  final AlbumApiProvider _albumApiProvider = Get.find<AlbumApiProvider>();
  final tokenService = TokenService();

  var userCount = 0.obs;
  var songCount = 0.obs;
  var playlistCount = 0.obs;
  var albumCount = 0.obs;
  var isLoading = false.obs;

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<SongItemModel> songs = <SongItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdminData();
  }

  Future<void> fetchAdminData() async {
    try {
      isLoading.value = true;
      final token = await tokenService.getToken();
      if(token == null)
        {
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

      users.clear();
      final userList = await _userApiProvider.getAllUsers(token);
      users.assignAll(userList);

      songs.clear();
      final songList = await _songApiProvider.getAllSong(token);
      songs.assignAll(songList);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteUser(String userId) async
  {
    try{
      isLoading.value = true;
      final token = await tokenService.getToken();
      
      if(token == null){
        return;
      }
      
      final result = await _userApiProvider.deleteUser(userId, token);
      
      if(result.isNotEmpty)
        {
          Get.snackbar("Success", "User deleted successfully");
          users.removeWhere((user) => user.id == userId);
          fetchAdminData();
        }
    }catch(e){
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> deleteSong(String songId) async
  {
    try{
      isLoading.value = true;
      final token = await tokenService.getToken();

      if(token == null){
        return;
      }

      final result = await _songApiProvider.deleteSong(token, songId);

      if(result.isNotEmpty)
        {
          Get.snackbar("Success", "User deleted successfully");
          songs.removeWhere((song) => song.id == songId);
          fetchAdminData();
        }
    }catch(e){
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

  void refreshData() {
    fetchAdminData();
  }
}