import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class ArtistModel {
  final String id;
  final String name;
  final String avatarUrl;
  final bool verify;
  final int followerCount;
  final List<SongItemModel> topSongs;
  final List<AlbumModel> albums;

  ArtistModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.verify,
    required this.followerCount,
    required this.topSongs,
    required this.albums,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      verify: json['verified'] as bool? ?? false,
      followerCount: json['followerCount'] as int,
      topSongs: (json['topSongs'] as List? ?? [])
          .map((e) => SongItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      albums: (json['albums'] as List? ?? [])
          .map((e) => AlbumModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'verified': verify,
      'followerCount': followerCount,
      'topSongs': topSongs.map((e) => e.toJson()).toList(),
      'albums': albums.map((e) => e.toJson()).toList(),
    };
  }

  ArtistModel copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    bool? verify,
    int? follower,
    List<SongItemModel>? topSongs,
    List<AlbumModel>? albums,
  }) {
    return ArtistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      verify: verify ?? this.verify,
      followerCount: follower ?? this.followerCount,
      topSongs: topSongs ?? this.topSongs,
      albums: albums ?? this.albums,
    );
  }
}