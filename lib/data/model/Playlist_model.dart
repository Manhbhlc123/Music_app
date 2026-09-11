class PlaylistModel {
  final String id;
  final String title;
  final String coverUrl;
  final int? totalSong;

  PlaylistModel({
    required this.id,
    required this.title,
    required this.coverUrl,
    this.totalSong,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      id: json["id"],
      title: json["title"],
      coverUrl: json["coverUrl"],
      totalSong: (json["totalSong"] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "coverUrl": coverUrl,
      "totalSong": totalSong,
    };
  }
  }