import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/createRequest/GenreCreate_request.dart';
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

  //func get genres count
  Future<int> getGenreCount(String token) async {
    try {
      final url = Uri.parse("$baseUrl/genres/count");
      final response = await api
          .get(url, {
            "Authorization": "Bearer $token",
            'Content-Type': 'application/json',
          })
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['result'] as int;
      } else {
        throw Exception("Failed to get genres count");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //func update genre
  Future<GenresModel> updateGenre(String token, GenresModel genre) async {
    try {
      final url = Uri.parse("$baseUrl/genres/${genre.id}");
      final response = await api
          .put(url, {
            "Authorization": "Bearer $token",
            'Content-Type': 'application/json',
          }, jsonEncode(genre))
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return GenresModel.fromJson(json['result']);
      } else {
        throw Exception("Failed to update genres");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //func delete genre
  Future<String> deleteGenre(String token, String genreId) async {
    try {
      final url = Uri.parse("$baseUrl/genres/${genreId}");
      final response = await api
          .delete(url, {
            "Authorization": "Bearer $token",
            'Content-Type': 'application/json',
          })
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['message'];
      } else {
        throw Exception("Failed to delete genres");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //func create genre
  Future<GenresModel> createGenre(
    String token,
    GenreCreateRequest request,
  ) async {
    try {
      final url = Uri.parse("$baseUrl/genres/create");
      final response = await api
          .post(url, {
            "Authorization": "Bearer $token",
            'Content-Type': 'application/json',
          }, jsonEncode(request))
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return GenresModel.fromJson(json['result']);
      } else {
        throw Exception("Failed to delete genres");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
