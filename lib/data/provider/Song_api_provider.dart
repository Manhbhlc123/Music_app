import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class SongApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final ApiClient api = ApiClient();
  final TokenService tokenService = TokenService();

  //increase play count
  Future<void> increasePlayCount(String token, String songId) async {
    final url = Uri.parse("$baseUrl/songs/$songId/play");

    final response = await api.patch(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    }, null);

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Increase play count failed: ${response.statusCode}");
    }
  }

  //get song of artist
  Future<List<SongItemModel>> getSongsOfArtist(
    String artistId,
    String token,
  ) async {
    try {
      final url = Uri.parse(
        "$baseUrl/songs/artists/${artistId}",
      ).replace(queryParameters: {"page": "0", "size": "10"});

      final response = await api
          .get(url, {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          })
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final result = json['result'];

        return result
            .map<SongItemModel>(
              (e) => SongItemModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw Exception(
          "Failed to fetch downloads. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //delete song
  Future<String> deleteSong(String token, String songId) async {
    try {
      final url = Uri.parse("$baseUrl/songs/$songId");

      final response = await api.delete(url, {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return json['message'] as String;
      } else {
        throw Exception(
          "Failed to delete song. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getSongCount(String token) async
  {
    final url = Uri.parse("$baseUrl/songs/count");
    final response = await api.get(url, {
      "Authorization": "Bearer $token",
    }).timeout(Duration(seconds: 5));

    if(response.statusCode == 200)
    {
      final json = jsonDecode(response.body);
      return json['result'] as int;
    }
    else {
      throw Exception("Failed to load song count");
    }
  }

  Future<SongItemModel> updateSong(SongItemModel data, String token) async
  {

    final url = Uri.parse("$baseUrl/songs/${data.id}");

    print("👉 CHỐT 2 - DỮ LIỆU GỬI LÊN SERVER: ${jsonEncode(data.toJson())}");

    final response = await api.patch(
        url,
        {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }, jsonEncode(data.toJson())
    ).timeout(Duration(seconds: 5));

    print("UPDATE USER RESPONSE:");
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SongItemModel.fromJson(json['result']);
    } else {
      throw Exception("Failed to update song information");
    }
  }

  Future<List<SongItemModel>> getAllSong(String token) async
  {
    final url = Uri.parse("$baseUrl/songs");
    final response = await api.get(url, {
      "Authorization": "Bearer $token",
    }).timeout(Duration(seconds: 5));

    if(response.statusCode == 200)
    {
      final json = jsonDecode(response.body);
      return (json['result'] as List).map((e) => SongItemModel.fromJson(e)).toList();
    }
    else {
      throw Exception("Failed to load song count");
    }
  }
}
