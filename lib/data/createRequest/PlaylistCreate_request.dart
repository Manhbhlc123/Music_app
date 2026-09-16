class PlaylistCreateRequest
{
  final String title;
  final bool isPublic;
  final String coverUrl;
  final bool isSystem;

  PlaylistCreateRequest({
    required this.title,
    required this.coverUrl,
    required this.isPublic,
    required this.isSystem,
  });

  factory PlaylistCreateRequest.fromJson(Map<String, dynamic> json) {
    return PlaylistCreateRequest(
      title: json['title'] ?? '',
      coverUrl: json['coverUrl'] ?? '',
      isPublic: json['isPublic'] ?? false,
      isSystem: json['isSystem'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isPublic': isPublic,
      'coverUrl': coverUrl,
      'isSystem': isSystem,
    };
  }
}