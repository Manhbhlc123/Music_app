import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/Follow_model.dart';

class FollowApiProvide {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();

  //lấy ds artist đã follow
  Future<List<ArtistModel>> getFollowedArtist(
    String token, {
    int page = 0,
    int size = 10,
  }) async {
    final url = Uri.parse("$baseUrl/follows").replace(
      queryParameters: {"page": page.toString(), "size": size.toString()},
    );
    final response = await api.get(url, {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json['result']['content'] as List)
          .map((item) => ArtistModel.fromJson(item))
          .toList();
    } else {
      throw Exception(
        "Failed to load followed artists: ${response.statusCode}",
      );
    }
  }

  Future<bool> followArtist(String token, String artistId) async {
    Uri url = Uri.parse("$baseUrl/follows/toggle/$artistId");
    final response = await api.post(url, {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    }, null);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final followModel = FollowModel.fromJson(json['result']);
      return followModel.isFollowing;
    } else {
      throw Exception("Failed to follow artist");
    }
  }

  //check current state
  Future<bool> checkState(String token, String artistId) async {
    Uri url = Uri.parse("$baseUrl/follows/state/$artistId");

    final response = await api.get(url, {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    });
    if(response.statusCode == 200)
      {
        final json = jsonDecode(response.body);
        return json['result'];
      }else{
      throw Exception("Failed to get State");
    }
  }
}
