class GenreCreateRequest
{
  final String name;
  final String description;
  final String coverUrl;

  GenreCreateRequest({required this.name, required this.description, required this.coverUrl});

  factory GenreCreateRequest.fromJson(Map<String, dynamic> json) {
    return GenreCreateRequest(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coverUrl: json['coverUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'coverUrl': coverUrl,
    };
  }
}