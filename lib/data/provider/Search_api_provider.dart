import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/Search_response_model.dart';
import 'package:sq_mp3/data/model/Trending_keyword_model.dart';

class SearchApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();

  Future<List<String>> getSearchHistory(String token) async {
    final url = Uri.parse("$baseUrl/search/history");

    final response = await api.get(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json["result"] as List).map((e) => e as String).toList();
    } else {
      throw Exception("Failed to load search history");
    }
  }

  //func get trending keywords
  Future<List<TrendingKeywordModel>> getTrending(String token) async {
    final url = Uri.parse("$baseUrl/search/trending");

    final response = await api.get(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json["result"] as List)
          .map((e) => TrendingKeywordModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load trending keywords");
    }
  }

  Future<SearchResponseModel> search(String token, String query) async {
    print("SEARCH CALLED: $query");

    final url = Uri.parse("$baseUrl/search").replace(
      queryParameters: {
        "keyword": query,
        "type": "ALL",
        "page": "0",
        "size": "20",
      },
    );

    final response = await api.get(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    try {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return SearchResponseModel.fromJson(json["result"]);
      } else {
        throw Exception("Failed to perform search");
      }
    } catch (e, s) {
      print("========== ERROR ==========");
      print(e);
      print(s);
      rethrow;
    }
  }

  Future<void> clearHistory(String token) async {
    final url = Uri.parse("$baseUrl/search/history");
    final response = await api.delete(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });
    if (response.statusCode != 200) {
      throw Exception("Clear history failed!");
    }
  }

  Future<void> deleteHistoryItem(String token, String keyword) async {
    final url = Uri.parse(
      "$baseUrl/search/history",
    ).replace(queryParameters: {"keyword": keyword});
    final response = await api.delete(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });
    if (response.statusCode != 200) {
      throw Exception("Failed to delete history item");
    }
  }

  Future<void> addSearchHistory(String token, String keyword) async {
    final url = Uri.parse("$baseUrl/search/create");

    final response = await api.post(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    }, jsonEncode({"keyword": keyword}));

    try {
      if (response.statusCode != 200) {
        throw Exception("Failed to add search history");
      }
    } catch (e) {
      throw Exception("Error adding search history: $e");
    }
  }
}
