import 'package:flutter/foundation.dart';

class FavoriteModel {
  String songId;
  bool isFavorite;
  String message;

  FavoriteModel({
    required this.songId,
    required this.isFavorite,
    required this.message,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      songId: json['songId'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'songId': songId,
      'isFavorite': isFavorite,
      'message': message,
    };
  }

  FavoriteModel copyWith({
    String? songId,
    bool? isFavorite,
    String? message,
  }) {
    return FavoriteModel(
      songId: songId ?? this.songId,
      isFavorite: isFavorite ?? this.isFavorite,
      message: message ?? this.message,
    );
  }
}
