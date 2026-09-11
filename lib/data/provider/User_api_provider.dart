import 'dart:convert';
import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/User_model.dart';

class UserApiProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();
  final tokenService = TokenService();

  Future<UserModel> updateUser(UserModel data, String token) async
  {

    final url = Uri.parse("$baseUrl/users/${data.id}");

    final response = await api.put(
      url,
      {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      }, jsonEncode(data.toJson())
    ).timeout(Duration(seconds: 5));

    print("UPDATE USER RESPONSE:");
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserModel.fromJson(json['result']);
    } else {
      throw Exception("Failed to update user information");
    }
  }

  //func get user information
  Future<UserModel> getMyProfile() async {
    final token = await tokenService.getToken();
    if (token == null) throw Exception("No token found");
    return getUser(token);
  }

  Future<UserModel> getUser(String token) async
  {
    final url = Uri.parse("$baseUrl/users/myInfo");
    final response = await api.get(url, {
      "Authorization": "Bearer $token",
    }).timeout(Duration(seconds: 5));

    if(response.statusCode == 200)
      {
        final json = jsonDecode(response.body);
        return UserModel.fromJson(json['result']);
      }
    else {
      throw Exception("Failed to load user information");
    }
  }

  Future<int> getUserCount(String token) async
  {
    final url = Uri.parse("$baseUrl/users/count");
    final response = await api.get(url, {
      "Authorization": "Bearer $token",
    }).timeout(Duration(seconds: 5));

    if(response.statusCode == 200)
    {
      final json = jsonDecode(response.body);
      return json['result'] as int;
    }
    else {
      throw Exception("Failed to load user count");
    }
  }

  Future<String> deleteUser(String userId, String token) async{
    final url = Uri.parse("$baseUrl/users/$userId");
    final response = await api.delete(url, {
      "Authorization": "Bearer $token",
    }).timeout(Duration(seconds: 5));

    if(response.statusCode == 200)
    {
      final json = jsonDecode(response.body);
      return json['result'];
    }
    else {
      throw Exception("Failed to delete user");
    }
  }

  // get all users
  Future<List<UserModel>> getAllUsers(String token) async
  {
    final url = Uri.parse("$baseUrl/users");
    final response = await api.get(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    }).timeout(Duration(seconds: 5));

    print("GET USERS RESPONSE:");
    print(response.body);
    print(url);
    if(response.statusCode == 200)
    {
      final json = jsonDecode(response.body);
      List<dynamic> data = json['result'];
      return data.map((user) => UserModel.fromJson(user)).toList();
    }
    else {
      throw Exception("Failed to load all users");
    }
  }
}