import 'package:flutter/cupertino.dart';

class AlbumCreateRequest{
  final String title;
  final String artistId;
  final String coverUrl;
  final DateTime releaseDate;
  final String description;

  AlbumCreateRequest({
    required this.title,
    required this.artistId,
    required this.coverUrl,
    required this.releaseDate,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artistId': artistId,
      'coverUrl': coverUrl,
      'releaseDate': releaseDate.toIso8601String(),
      'description': description,
    };
  }
}