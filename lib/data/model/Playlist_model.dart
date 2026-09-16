class PlaylistModel {
  final String id;
  final String title;
  final String coverUrl;
  final int? totalSong;
  final bool isPublic;

  PlaylistModel({
    required this.id,
    required this.title,
    required this.coverUrl,
    this.totalSong,
    required this.isPublic,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json["id"],
      title: json["title"],
      coverUrl: json["coverUrl"],
      totalSong: (json["totalSong"] as num?)?.toInt() ?? 0,
      isPublic: json['isPublic'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "coverUrl": coverUrl,
      "totalSong": totalSong,
      "isPublic": isPublic,
    };
  }

  PlaylistModel copyWith({
    String? id,
    String? title,
    String? coverUrl,
    int? totalSong,
    bool? isPublic,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      totalSong: totalSong ?? this.totalSong,
      isPublic: isPublic ?? this.isPublic,
    );
  }
  }