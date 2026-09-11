class AlbumModel
{
  final String id;
  final String title;
  final String cover;

  AlbumModel({
    required this.id,
    required this.title,
    required this.cover,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'] as String,
      title: json['title'] as String,
      cover: json['coverUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'coverUrl': cover,
    };
  }

  AlbumModel copyWith({
    String? id,
    String? title,
    String? cover,
  }) {
    return AlbumModel(
      id: id ?? this.id,
      title: title ?? this.title,
      cover: cover ?? this.cover,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          cover == other.cover;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ cover.hashCode;

  @override
  String toString() => 'AlbumModel(id: $id, title: $title, cover: $cover)';
}