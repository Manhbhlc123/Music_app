class RecentSongModel {
  final String id;
  final String songId;
  final String songTitle;
  final String artistName;
  final String coverUrl;
  final int playDuration;
  final String source;
  final DateTime playedAt;

  RecentSongModel({
    required this.id,
    required this.songId,
    required this.songTitle,
    required this.artistName,
    required this.coverUrl,
    required this.playDuration,
    required this.source,
    required this.playedAt,
  });

  factory RecentSongModel.fromJson(Map<String, dynamic> json) {

    return RecentSongModel(
      id: json['id']?.toString() ?? '',
      songId: json['songId']?.toString() ?? '',
      songTitle: json['songTitle']?.toString() ?? '',
      artistName: json['artistName']?.toString() ?? '',
      coverUrl: json['coverUrl']?.toString() ?? '',
      playDuration: json['playDuration'] is int
          ? json['playDuration']
          : int.tryParse(json['playDuration']?.toString() ?? '0') ?? 0,
      source: json['source']?.toString() ?? '',
      playedAt: DateTime.parse(json['playedAt'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'songId': songId,
      'songTitle': songTitle,
      'artistName': artistName,
      'coverUrl': coverUrl,
      'playDuration': playDuration,
      'source': source,
      'playedAt': playedAt.toIso8601String(),
    };
  }

  RecentSongModel copyWith({
    String? id,
    String? songId,
    String? coverUrl,
    String? songTitle,
    String? artistName,
    String? coverId,
    int? playDuration,
    String? source,
    DateTime? playedAt,
  }) {
    return RecentSongModel(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      songTitle: songTitle ?? this.songTitle,
      artistName: artistName ?? this.artistName,
      coverUrl: coverUrl ?? this.coverUrl,
      playDuration: playDuration ?? this.playDuration,
      source: source ?? this.source,
      playedAt: playedAt ?? this.playedAt,
    );
  }
}