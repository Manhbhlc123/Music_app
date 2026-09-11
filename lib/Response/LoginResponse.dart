class LoginResponse {
  String token;
  bool authenticated;

  LoginResponse({required this.token, required this.authenticated});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final result = json["result"];


    return LoginResponse(
      token: result['token'] ?? '',
      authenticated: result['authenticated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'authenticated': authenticated};
  }
}
