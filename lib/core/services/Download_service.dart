import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  final Dio dio = Dio();

  //get local path
  Future<String> getDownloadDirectory() async {
    final directory = await getApplicationDocumentsDirectory();

    final downloadDirectory = Directory('${directory.path}/downloads');

    if (!await downloadDirectory.exists()) {
      await downloadDirectory.create(recursive: true);
    }

    return downloadDirectory.path;
  }

  Future<String> downloadSong({
    required String songId,
    required String downloadUrl,
    Function(double progress)? onProgress,
  }) async {
    try {
      final directoryPath = await getDownloadDirectory();
      final filePath = '$directoryPath/$songId.mp3';

      await dio.download(
        downloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1 && onProgress != null) {
            onProgress.call(received / total);
          }
        },
      );
      return filePath;
    } catch (e) {
      rethrow;
    }
  }

  //function check exists
  Future<bool> isFileExists(String songId) async {
    final directory = await getDownloadsDirectory();
    final file = File('$directory/$songId.mp3');
    return await file.exists();
  }

  //function deleteSong
  Future<void> deleteSong(String songId) async
  {
    final directory = await getDownloadsDirectory();
    final file = File('$directory/$songId.mp3');
    if(await file.exists())
      {
        await file.delete();
      }
  }
}
