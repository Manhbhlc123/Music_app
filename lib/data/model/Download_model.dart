class DownloadModel {
  final String downloadId;
  final String songId;
  final String songTitle;
  final String downloadUrl;
  final String quality;
  final int remainingDownloadThisMonth;
  DateTime downloadedAt;

  DownloadModel({
    required this.downloadId,
    required this.songId,
    required this.songTitle,
    required this.downloadUrl,
    required this.quality,
    required this.remainingDownloadThisMonth,
    required this.downloadedAt,
  });

  factory DownloadModel.fromJson(Map<String, dynamic> json) {
    return DownloadModel(
      downloadId: json['downloadId'] as String,
      songId: json['songId'] as String,
      songTitle: json['songTitle'] as String,
      downloadUrl: json['downloadUrl'] as String,
      quality: json['quality'] as String,
      remainingDownloadThisMonth: json['remainingDownloadThisMonth'] as int,
      downloadedAt: DateTime.parse(json['downloadedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'downloadId': downloadId,
      'songId': songId,
      'songTitle': songTitle,
      'downloadUrl': downloadUrl,
      'quality': quality,
      'remainingDownloadThisMonth': remainingDownloadThisMonth,
      'downloadedAt': downloadedAt.toIso8601String(),
    };
  }

  DownloadModel copyWith({
    String? downloadId,
    String? songId,
    String? songTitle,
    String? downloadUrl,
    String? quality,
    int? remainingDownloadThisMonth,
    DateTime? downloadedAt,
  }) {
    return DownloadModel(
      downloadId: downloadId ?? this.downloadId,
      songId: songId ?? this.songId,
      songTitle: songTitle ?? this.songTitle,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      quality: quality ?? this.quality,
      remainingDownloadThisMonth: remainingDownloadThisMonth ??
          this.remainingDownloadThisMonth,
      downloadedAt: downloadedAt ?? this.downloadedAt,
    );
  }
}


