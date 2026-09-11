import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';

class ArtistApiProvider {
  final api = ApiClient();
  final String baseUrl = BaseUrlApiModel().baseUrl;
  //func get all artists
  Future<List<ArtistModel>> getAllArtists(String token) async {
    try {
      final url = Uri.parse('$baseUrl/artists');
      final response = await api.get(url, {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }).timeout(Duration(seconds: 15));

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
}
