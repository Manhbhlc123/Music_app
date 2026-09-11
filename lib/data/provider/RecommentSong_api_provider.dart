import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class RecommentSongApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();

  Future<List<SongItemModel>> getRecommendSongs(String token) async {
    try {
      final url = Uri.parse('$baseUrl/songs');
      final response = await api
          .get(url, {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          })
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return (json["result"] as List)
            .map((e) => SongItemModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load recommended songs');
      }
    } catch (e) {
      throw Exception('Error fetching recommended songs: $e');
    }
  }
}
