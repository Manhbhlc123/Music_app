class ApiResponse<T> {
  final int code;
  final String? message;
  final T result;

  ApiResponse({
    required this.code,
    this.message,
    required this.result,
  });

  bool get isSuccess => code == 200;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return ApiResponse<T>(
      code: json['code'] as int,
      message: json['message'] as String?,
      result: fromJsonT(json['result']),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'code': code,
      'message': message,
      'result': toJsonT(result),
    };
  }
}