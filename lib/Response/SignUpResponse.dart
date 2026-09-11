class SignUpResponse {
  final String token;
  final String message;

  SignUpResponse({required this.token, required this.message});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      token: json['token'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'message': message};
  }
}
