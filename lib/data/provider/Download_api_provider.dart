import 'dart:convert';
import 'dart:ffi';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/core/services/Download_service.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/Download_model.dart';

class DownloadApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();


  Future<List<DownloadModel>> getDownloadSong(String token) async {
    if (token.isEmpty) {
      throw Exception("No token found");
    }
    final url = Uri.parse(
      "$baseUrl/downloads",
    ).replace(queryParameters: {"page": "0", "size": "10"});
    final response = await api
        .get(url, {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        })
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["result"];
      final List content = result["content"] ?? [];

      return content
          .map((e) => DownloadModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        "Failed to fetch downloads. Status code: ${response.statusCode}",
      );
    }
  }

  Future<int> getRemainingDownloads(String token) async {
    if (token.isEmpty) {
      throw Exception("No token found");
    }
    final url = Uri.parse("$baseUrl/downloads/remainingDownloadThisMonth");
    final response = await api.get(url, {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    }).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["result"] as int;
    } else {
      throw Exception(
        "Failed to fetch remaining downloads. Status code: ${response.statusCode}",
      );
    }
  }

  Future<DownloadModel> downloadSong({
    required String token,
    required String songId,
    String quality = "normal",
  }) async {
    try {
      final url = Uri.parse(
        "$baseUrl/downloads",
      );

      final localPath = await DownloadService().getDownloadDirectory();

      final body = jsonEncode({
        "songId": songId,
        "quality": quality,
        "fileLocalPath": localPath,
      });

      print("DOWNLOAD REQUEST: $body");

      final response = await api.post(
        url,
        {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body,
      );

      print("DOWNLOAD STATUS: ${response.statusCode}");
      print("DOWNLOAD BODY: ${response.body}");

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final json = jsonDecode(response.body);

        return DownloadModel.fromJson(
          json["result"] as Map<String, dynamic>,
        );
      }

      throw Exception(
        "Download failed. Status code: ${response.statusCode}",
      );
    } catch (e) {
      print("Download song error: $e");
      rethrow;
    }
  }
}

