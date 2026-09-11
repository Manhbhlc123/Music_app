import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sq_mp3/Response/LoginResponse.dart';
import 'package:sq_mp3/Response/SignUpResponse.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';

class AuthApiProvide {
  final String baseUrl = BaseUrlApiModel().baseUrl;

  //func login
  Future<LoginResponse> login(String email, String password) async {
    try
    {
      final url = Uri.parse("$baseUrl/auth/login");
      final response = await http.post(
        url,
        body: jsonEncode({"email": email, "password": password}),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 15));

      if(response.statusCode == 200)
      {
        return LoginResponse.fromJson(jsonDecode(response.body));
      }
      else
      {
        throw Exception(response.body.toString());
      }
    }catch (e)
    {
      print(e);
      rethrow;
    }
  }

  //func SignUp
  Future<SignUpResponse> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int birthYear,
    required String country,
    required String language,
    bool is_vip = false,
    bool vip_auto_renew = false,
    DateTime? vip_expired_at = null,
    bool two_factor_enable = false,
    String status = "Active",
    DateTime? update_at = null,
    String? theme_color = null,
    required DateTime create_at,
    String? imageUrl,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/users/create/user");
      final response = await http
          .post(
        url,
        body: jsonEncode({
          'name': name,
          'email': email,
          'password_has': password,
          'phone': phone,
          'birthday_year': birthYear,
          'country': country,
          'avatar_url': imageUrl,
          'theme_color': theme_color,
          'language': language,
          'is_vip': is_vip,
          'vip_auto_renew': vip_auto_renew,
          'vip_expired_at': vip_expired_at?.toIso8601String(),
          'two_factor_enable': two_factor_enable,
          'status': status,
          'create_at': create_at.toIso8601String(),
          'update_at': update_at?.toIso8601String(),
        }),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return SignUpResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body.toString());
      }
    } catch (e) {
      print("Error during sign up: $e");
      rethrow;
    }
  }
}