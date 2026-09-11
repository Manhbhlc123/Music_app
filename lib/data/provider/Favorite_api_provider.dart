import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class FavoriteApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();

  //func get all favorites
  Future<List<SongItemModel>> getAllFavorites(String token) async {
    try {
      final url = Uri.parse('$baseUrl/favorites');
      final response = await api
          .get(url, {'Authorization': 'Bearer $token'})
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return (json["result"]["content"] as List)
            .map((e) => SongItemModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      throw Exception('Error fetching favorites: $e');
    }
  }

  //func toggle favorite
  Future<bool> toggleFavorite(String token, String songId) async {
    try {
      final url = Uri.parse('$baseUrl/favorites/toggle/$songId');
      final response = await api
          .post(url, {'Authorization': 'Bearer $token'}, {})
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        return json['result']['favorite'];
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error toggling favorite: $e');
    }
  }
}
