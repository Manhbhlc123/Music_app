import 'dart:convert';

import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiClient {
  final TokenService tokenService = TokenService();

  Future<http.Response> get(Uri url, Map<String, String> headers) async {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 401) {
      await tokenService.clearAll();
      Get.offAllNamed(Routes.login);
    }
    return response;
  }

  Future<http.Response> post(
    Uri url,
    Map<String, String> headers,
    Object? body,
  ) async {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 401) {
      await tokenService.clearAll();
      Get.offAllNamed(Routes.login);
    }
    return response;
  }

  Future<http.Response> put(
    Uri url,
    Map<String, String> headers,
    Object? body,
  ) async {
    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 401) {
      await tokenService.clearAll();
      Get.offAllNamed(Routes.login);
    }
    return response;
  }


  Future<http.Response> patch(
    Uri url,
    Map<String, String> headers,
    Object? body,
  ) async {
    final response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 401) {
      await tokenService.clearAll();
      Get.offAllNamed(Routes.login);
    }
    return response;
  }

  Future<http.Response> delete(
    Uri url,
    Map<String, String> headers,
  ) async {
    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 401) {
      await tokenService.clearAll();
      Get.offAllNamed(Routes.login);
    }
    return response;
  }


}
