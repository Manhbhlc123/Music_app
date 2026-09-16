class SongItemModel {
  final String id;
  final String title;
  final String audioUrlNormal;
  final String audioUrlHq;
  final String artistId;
  final String artistName;
  final String albumId;
  final String genreId;
  final String lyricsPlain;
  final String coverUrl;
  final int playCount;
  final int duration;

  SongItemModel({
    required this.id,
    required this.title,
    required this.audioUrlNormal,
    required this.audioUrlHq,
    required this.artistId,
    required this.artistName,
    required this.albumId,
    required this.genreId,
    required this.lyricsPlain,
    required this.coverUrl,
    required this.playCount,
    required this.duration,
  });

  factory SongItemModel.fromJson(Map<String, dynamic> json) {
    return SongItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      audioUrlNormal: json['audioUrlNormal'] as String,
      audioUrlHq: json['audioUrlHq'] as String,
      artistId: json['artistId'] as String,
      artistName: json['artistName'] as String,
      albumId: json['albumId'] as String,
      genreId: json['genreId'] as String,
      lyricsPlain: json['lyricsPlain'] as String,
      coverUrl: json['coverUrl'] as String,
      duration: json['duration'] as int,
      playCount: json['playCount'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'audioUrlNormal': audioUrlNormal,
        'audioUrlHq': audioUrlHq,
        'artistId': artistId,
        'artistName': artistName,
        'albumId': albumId,
        'genreId': genreId,
        'lyricsPlain': lyricsPlain,
        'coverUrl': coverUrl,
        'duration': duration,
        'playCount': playCount,
      };

  SongItemModel copyWith({
    String? id,
    String? title,
    String? audioUrlNormal,
    String? audioUrlHq,
    String? artistId,
    String? artistName,
    String? albumId,
    String? genreId,
    String? lyricsPlain,
    String? coverUrl,
    int? playCount,
    int? duration,
  }) {
    return SongItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      audioUrlNormal: audioUrlNormal ?? this.audioUrlNormal,
      audioUrlHq: audioUrlHq ?? this.audioUrlHq,
      artistId: artistId ?? this.artistId,
      artistName: artistName ?? this.artistName,
      albumId: albumId ?? this.albumId,
      genreId: genreId ?? this.genreId,
      lyricsPlain: lyricsPlain ?? this.lyricsPlain,
      coverUrl: coverUrl ?? this.coverUrl,
      playCount: playCount ?? this.playCount,
      duration: duration ?? this.duration,
    );
  }

}
