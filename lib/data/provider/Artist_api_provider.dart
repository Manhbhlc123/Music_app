import 'dart:convert';
import 'dart:ffi';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/createRequest/ArtistCreate_request.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';

class ArtistApiProvider {
  final api = ApiClient();
  final String baseUrl = BaseUrlApiModel().baseUrl;

  //func get all artists
  Future<List<ArtistModel>> getAllArtists(String token) async {
    try {
      final url = Uri.parse('$baseUrl/artists');
      final response = await api
          .get(url, {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          })
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return (json["result"] as List)
            .map((e) => ArtistModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load artist');
      }
    } catch (e) {
      throw Exception('Error fetching artist: $e');
    }
  }

  //func delete
  Future<String> deleteArtist(String token, String artistId) async {
    try {
      final url = Uri.parse('$baseUrl/artists/$artistId');
      final response = await api
          .delete(url, {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          })
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return json['message'];
      } else {
        throw Exception('Failed to load artist');
      }
    } catch (e) {
      throw Exception('Error fetching artist: $e');
    }
  }

  //func update artist
  Future<ArtistModel> updateArtist(String token, ArtistModel artist) async {
    try {
      final url = Uri.parse('$baseUrl/artists/${artist.id}');
      final response = await api
          .put(url, {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }, jsonEncode(artist))
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return ArtistModel.fromJson(json['result']);
      } else {
        throw Exception('Failed to load artist');
      }
    } catch (e) {
      throw Exception('Error fetching artist: $e');
    }
  }

  //func create artist
  Future<ArtistModel> createArtist(String token, ArtistCreateRequest request) async
  {
    try {
      final url = Uri.parse('$baseUrl/artists/create');
      final response = await api
          .post(url, {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }, jsonEncode(request))
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return ArtistModel.fromJson(json['result']);
      } else {
        throw Exception('Failed to load artist');
      }
    } catch (e) {
      throw Exception('Error fetching artist: $e');
    }
  }

  //func get artist count
  Future<int> getArtistCount(String token) async
  {
    try {
      final url = Uri.parse('$baseUrl/artists/count');
      final response = await api
          .get(url, {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      })
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return json['result'] as int;
      } else {
        throw Exception('Failed to load artist count');
      }
    } catch (e) {
      throw Exception('Error fetching artist count: $e');
    }
  }
}
