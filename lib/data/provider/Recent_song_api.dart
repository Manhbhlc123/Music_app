import 'dart:convert';
import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/Recent_song_model.dart';

class RecentSongApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final ApiClient api = ApiClient();
  final TokenService tokenService = TokenService();

  Future<List<RecentSongModel>> getRecentSongs() async {
    final token = await tokenService.getToken();
    return getRecentHistory(token ?? "");
  }

  Future<List<RecentSongModel>> getRecentHistory(String token) async {
    if (token.isEmpty) {
      throw Exception("No token found");
    }

    final url = Uri.parse(
      "$baseUrl/listenHistory",
    ).replace(queryParameters: {"limit": "10"});

    final response = await api.get(url, {
      "Authorization": "Bearer $token",
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return (json['result'] as List)
          .map((e) => RecentSongModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw Exception("Failed to load listen history");
  }

  Future<void> addToRecentHistory(
    String songId,
    int duration,
    String source,
  ) async {
    final token = await tokenService.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("No token found");
    }

    final url = Uri.parse("$baseUrl/listenHistory");

    final response = await api.post(
      url,
      {"Authorization": "Bearer $token", 'Content-Type': 'application/json'},
      jsonEncode({
        "songId": songId,
        "playDuration": duration,
        "source": source,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to add to listen history");
    }
  }

  Future<String> deleteSongInListenHistory(String token, String id) async {
    try {
      final url = Uri.parse("$baseUrl/listenHistory/$id");
      final response = await api
          .delete(url, {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          })
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return json['message'];
      } else {
        throw Exception(
          "Failed to delete song in listen history. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> deleteAll(String token) async {
    try {
      final url = Uri.parse("$baseUrl/listenHistory");
      final response = await api
          .delete(url, {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          })
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 201 || response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return json['message'];
      } else {
        throw Exception(
          "Failed to delete all song in listen history. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
