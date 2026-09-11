import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/SongLyricResponse_model.dart';

class SongLyricApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();
  final TokenService tokenService = TokenService();

  Future<SongLyricResponseModel> getLyrics(String songId) async {
    final token = await tokenService.getToken();

    if (token == null) {
      throw Exception("Token không tồn tại");
    }

    final url = Uri.parse("$baseUrl/songs/$songId/lyrics");

    final response = await api.get(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return SongLyricResponseModel.fromJson(json['result']);
    }

    throw Exception("Không thể lấy lời bài hát");
  }
}
