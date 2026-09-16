class GenresModel {
  String id;
  String name;
  String description;
  String coverUrl;

  GenresModel({required this.id, required this.name, required this.description, required this.coverUrl});

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coverUrl: json['coverUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'coverUrl': coverUrl};
  }
}