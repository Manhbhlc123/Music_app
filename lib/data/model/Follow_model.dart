class FollowModel {
  final String artistId;
  final bool isFollowing;

  FollowModel({
    required this.artistId,
    required this.isFollowing,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) {
    return FollowModel(
      artistId: json['artistId'] ?? '',
      isFollowing: json['isFollowing'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artistId': artistId,
      'isFollowing': isFollowing,
    };
  }
}