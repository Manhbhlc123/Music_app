class AlbumModel
{
  final String id;
  final String title;
  final String cover;
  final String description;
  final int totalSongs;

  AlbumModel({
    required this.id,
    required this.title,
    required this.cover,
    required this.description,
    required this.totalSongs,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'] as String,
      title: json['title'] as String,
      cover: json['coverUrl'] as String,
      description: json['description'] as String,
      totalSongs: json['totalSongs'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'coverUrl': cover,
      'description': description,
      'totalSongs': totalSongs,
    };
  }

  AlbumModel copyWith({
    String? id,
    String? title,
    String? cover,
    String? description,
    int? totalSong,
  }) {
    return AlbumModel(
      id: id ?? this.id,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      description: description ?? this.description,
      totalSongs: totalSong ?? this.totalSongs,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          cover == other.cover &&
          description == other.description &&
          totalSongs == other.totalSongs;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ cover.hashCode ^ description.hashCode;

  @override
  String toString() => 'AlbumModel(id: $id, title: $title, cover: $cover, description: $description, totalSongs: $totalSongs)';
}