import 'package:sq_mp3/data/model/Download_model.dart';

class LocalDownloadModel {
  final DownloadModel downloadModel;
  final String localPath;

  LocalDownloadModel({required this.downloadModel, required this.localPath});

  Map<String, dynamic> toJson() {
    return {'download': downloadModel.toJson(), 'localPath': localPath};
  }

  factory LocalDownloadModel.fromJson(Map<String, dynamic> json) {
    return LocalDownloadModel(
      downloadModel: DownloadModel.fromJson(
        Map<String, dynamic>.from(json['download']),
      ),
      localPath: json['localPath'] ?? '',
    );
  }
}
