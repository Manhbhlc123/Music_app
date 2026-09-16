class SongCreateRequest {
  String title;
  String artistId;
  String albumId;
  String genreId;
  int duration;
  String audioUrlNormal;
  String audioUrlHq;
  String coverUrl;
  String lyricsPlain;



  SongCreateRequest({
    required this.title,
    required this.artistId,
    required this.albumId,
    required this.genreId,
    required this.duration,
    required this.audioUrlNormal,
    required this.audioUrlHq,
    required this.coverUrl,
    required this.lyricsPlain,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artistId': artistId,
      'albumId': albumId,
      'genreId': genreId,
      'duration': duration,
      'audioUrlNormal': audioUrlNormal,
      'audioUrlHq': audioUrlHq,
      'coverUrl': coverUrl,
      'lyricsPlain': lyricsPlain,
    };
  }


}