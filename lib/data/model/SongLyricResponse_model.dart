import 'package:sq_mp3/data/model/LyricLine_model.dart';

class SongLyricResponseModel {
  final String songId;
  final List<LyricLineModel> lyrics;

  SongLyricResponseModel({
    required this.songId,
    required this.lyrics,
  });

  factory SongLyricResponseModel.fromJson(
      Map<String, dynamic> json) {
    return SongLyricResponseModel(
      songId: json['songId'] as String,
      lyrics: (json['lyrics'] as List)
          .map(
            (item) => LyricLineModel.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'songId': songId,
      'lyrics': lyrics.map((item) => item.toJson()).toList(),
    };
  }
}