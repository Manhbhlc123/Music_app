class BannerModel {
  final String id;
  final String title;
  final String imageUrl;
  final String? redirectType;
  final String? redirectId;
  final int sortOrder;
  final bool isActive;

  BannerModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.redirectType,
    this.redirectId,
    this.sortOrder = 0,
    this.isActive = true,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      redirectType: json['redirectType'] as String?,
      redirectId: json['redirectId'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'redirectType': redirectType,
      'redirectId': redirectId,
      'sortOrder': sortOrder,
      'isActive': isActive,
    };
  }
}