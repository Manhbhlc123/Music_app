import 'dart:convert';

import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/model/Banner_model.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';

class BannerApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();
  Future<List<BannerModel>> getAllBanner(String token) async
  {
    try{
      final url = Uri.parse('$baseUrl/banners/getAllBanner');
      final response = await api.get(url, {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },).timeout(Duration(seconds: 15));

      if(response.statusCode == 200)
      {
        final json = jsonDecode(response.body);
        return (json["result"] as List)
            .map((e) => BannerModel.fromJson(e))
            .toList();
      }else
      {
        throw Exception('Failed to load banners');
      }
    }catch(e)
    {
      throw Exception('Error fetching banner: $e');
    }
  }

}