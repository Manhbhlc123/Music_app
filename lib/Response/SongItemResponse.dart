class SongItemResponse
{
  final String id;
  final String title;
  final String? coverUrl;
  final String artistName;
  final int duration;

  SongItemResponse({
    required this.id,
    required this.title,
    this.coverUrl,
    required this.artistName,
    this.duration = 0,
  });

  factory SongItemResponse.fromJson(Map<String, dynamic> json) {
    return SongItemResponse(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      coverUrl: json['coverUrl'] as String?,
      artistName: json['artistName'] as String? ?? '',
      duration: (json['duration'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      'id': id,
      'title': title,
      'coverUrl': coverUrl,
      'artistName': artistName,
      'duration': duration,
    };
  }
}