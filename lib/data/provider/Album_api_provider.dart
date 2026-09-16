import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/createRequest/AlbumCreate_request.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class AlbumApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();

  //create
  Future<AlbumModel> createAlbum(String token, AlbumCreateRequest request) async {
    try {
      final url = Uri.parse("$baseUrl/albums/create");
      final response = await api
          .post(url, {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      jsonEncode(request),
      )
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return AlbumModel.fromJson(json["result"]);
      } else {
        throw Exception("Fail to load album");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //lấy album
  Future<List<AlbumModel>> getAlbum(String token) async {
    try {
      final url = Uri.parse("$baseUrl/albums");
      final response = await api
          .get(url, {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          })
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return (json["result"] as List)
            .map((e) => AlbumModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Fail to load album");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //lấy song của album
  Future<List<SongItemModel>> getSongOfAlbum(String token, String albumId) async {
    try {
      final url = Uri.parse("$baseUrl/albums/$albumId/songs");
      final response = await api
          .get(url, {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          })
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return (json["result"] as List)
            .map((e) => SongItemModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Fail to load songs of album");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // xóa album
  Future<String> removeAlbum(String token, String albumId) async {
    try {
      final url = Uri.parse("$baseUrl/albums/$albumId");
      final response = await api
          .delete(url, {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }).timeout(Duration(seconds: 5));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception("Fail to remove album");
      } else {
        return "Album removed successfully";
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<int> getAlbumCount(String token) async {
      final url = Uri.parse("$baseUrl/albums/count");
    final response = await api.get(url, {
      "Authorization": "Bearer $token",
    }).timeout(Duration(seconds: 5));

    if(response.statusCode == 200)
    {
      final json = jsonDecode(response.body);
      return json['result'] as int;
    }
    else {
      throw Exception("Failed to load album count");
    }
  }


  // cập nhật album
  Future<AlbumModel> updateAlbum(AlbumModel album, String token) async {
    try {
      final url = Uri.parse("$baseUrl/albums/update/${album.id}");
      final response = await api
          .put(
            url,
            {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            jsonEncode(album.toJson()),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return AlbumModel.fromJson(json["result"]);
      } else {
        throw Exception("Failed to update album");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
