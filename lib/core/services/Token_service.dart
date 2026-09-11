import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService
{

  final _storage = const FlutterSecureStorage();
  static const _emailKey = 'user_email';
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';


  Future<void> saveToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<bool> hasToken() async {
    String? token = await getToken();
    return token != null;
  }

  Future<void> saveEmail(String email) async {
    await _storage.write(key: _emailKey, value: email);
  }

  Future<String?> getEmail() async {
    return await _storage.read(key: _emailKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}