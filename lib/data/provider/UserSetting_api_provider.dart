import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/UserSetting.dart';

class UserSettingApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();
  final tokenService = TokenService();

  Future<UserSetting> getUserSetting(String token) async {
    try {
      final url = Uri.parse("$baseUrl/userSetting");

      final response = await api.get(url, {"Authorization": "Bearer $token"});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        return UserSetting.fromJson(json['result']);
      } else {
        throw Exception("can't get user setting");
      }
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  Future<String> updateDownload(String token, UserSetting userSetting) async {
    try {
      final url = Uri.parse("$baseUrl/userSetting");

      final response = await api.put(
        url,
        {"Authorization": "Bearer $token", 'Content-Type': "application/json"},
        jsonEncode(userSetting.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        return json['message'];
      } else {
        throw Exception("can't update download setting");
      }
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
}
