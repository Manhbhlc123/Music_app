import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/model/Trending_keyword_model.dart';
import 'package:sq_mp3/data/provider/Search_api_provider.dart';

class SearchControllerHome extends GetxController {
  final searchTextController = TextEditingController();
  final TokenService tokenService = TokenService();
  final SearchApiProvider apiProvider = SearchApiProvider();

  RxBool loading = true.obs;
  RxInt currentTag = 0.obs;

  RxList<String> histories = <String>[].obs;
  RxList<TrendingKeywordModel> trendingKeywords = <TrendingKeywordModel>[].obs;
  RxList<SongItemModel> songs = <SongItemModel>[].obs;
  RxList<ArtistModel> artists = <ArtistModel>[].obs;
  RxList<AlbumModel> albums = <AlbumModel>[].obs;
  RxList<PlaylistModel> playlists = <PlaylistModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
    loadTrending();
  }

  Future<void> loadHistory() async {
    loading.value = true;
    try {
      final token = await tokenService.getToken();
      final result = await apiProvider.getSearchHistory(token!);
      histories.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> loadTrending() async {
    loading.value = true;
    try {
      final token = await tokenService.getToken();
      final result = await apiProvider.getTrending(token!);
      trendingKeywords.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    loading.value = true;
    try {
      final token = await tokenService.getToken();
      final result = await apiProvider.search(token!, query);

      await apiProvider.addSearchHistory(token, query);

      print("Song");
      songs.assignAll(result.songs);
      print("artist");
      artists.assignAll(result.artists);
      print("album");
      albums.assignAll(result.albums);
      print("playlist");
      playlists.assignAll(result.playlists);

      histories.remove(query);
      histories.insert(0, query);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> deleteHistoryItem(String keyword) async {
    try {
      final token = await tokenService.getToken();
      if (token != null) {
        await apiProvider.deleteHistoryItem(token, keyword);
        histories.remove(keyword);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> clearHistory() async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Xóa lịch sử"),
        content: const Text("Bạn có muốn cóa toàn bộ lịch sử tìm kiếm không?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text("Hủy"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text("Xóa"),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      final token = await tokenService.getToken();
      await apiProvider.clearHistory(token!);
      histories.clear();
      Get.snackbar("Thành công", "Đã xóa toàn bộ lịch sử tìm kiếm");
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
    }
  }
}
