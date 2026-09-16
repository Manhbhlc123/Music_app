import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/genre_model.dart';

class GenresApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();

  //func get all genres
  Future<List<GenresModel>> getAllGenres(String token) async {
    try {
      final url = Uri.parse("$baseUrl/genres");
      final response = await api
          .get(url, {
            "Authorization": "Bearer $token",
            'Content-Type': 'application/json',
          })
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return (json['result'] as List)
            .map((e) => GenresModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to get genres");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
