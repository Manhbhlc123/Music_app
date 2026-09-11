import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sq_mp3/core/services/Download_service.dart';
import 'package:sq_mp3/data/model/Download_model.dart';
import 'package:sq_mp3/data/model/LocalDownload_model.dart';

class DownloadController extends GetxController {
  final DownloadService downloadService = DownloadService();

  final GetStorage storage = GetStorage();

  final RxList<LocalDownloadModel> downloads = <LocalDownloadModel>[].obs;

  final RxDouble progress = 0.0.obs;

  static const String downloadKey = 'local_downloads';

  RxBool isDownloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    LoadLocalDownload();
  }

  void LoadLocalDownload() {
    final data = storage.read<List>(downloadKey);

    if (data == null) {
      downloads.clear();
      return;
    }
    downloads.assignAll(
      data
          .map(
            (item) =>
                LocalDownloadModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(),
    );
    checkMissingFiles();
  }

  Future<void> saveLocalDownloads() async {
    await storage.write(downloadKey, downloads.map((e) => e.toJson()).toList());
  }

  Future<void> downloadSong(DownloadModel download) async {
    try {
      isDownloading.value = true;
      progress.value = 0;

      //check downloaded
      final exists = downloads.any(
        (item) => item.downloadModel.songId == download.songId,
      );
      if (exists) {
        Get.snackbar("Thông báo", "Bài này đã được tải");
        return;
      }

      print("Bắt đầu download: ${download.songTitle}");
      print("Url: ${download.downloadUrl}");

      final localPath = await downloadService.downloadSong(
        songId: download.songId,
        downloadUrl: download.downloadUrl,
        onProgress: (value) {
          progress.value = value;
          print(
            'Download: '
            '${(value * 100).toStringAsFixed(1)}%',
          );
        },
      );

      final localDownload = LocalDownloadModel(
        downloadModel: download,
        localPath: localPath,
      );

      downloads.add(localDownload);
      await saveLocalDownloads();
      Get.snackbar("Thành công", "Đã tải xong: ${download.songTitle}");
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể tải bài hát: $e");
    } finally {
      isDownloading.value = false;
      progress.value = 0;
    }
  }

  bool isDownloaded(String songId) {
    return downloads.any((item) => item.downloadModel.songId == songId);
  }

  Future<void> deleteDownload(LocalDownloadModel item) async {
    try {
      await downloadService.deleteSong(item.downloadModel.songId);

      downloads.removeWhere(
        (e) => e.downloadModel.songId == item.downloadModel.songId,
      );

      await saveLocalDownloads();
      Get.snackbar("Thành công", "Đã xóa bài hát");
    } catch (e) {
      print(e);
    }
  }

  //check file
  Future<void> checkMissingFiles() async {
    final validDownload = <LocalDownloadModel>[];

    for (final item in downloads) {
      final exists = await downloadService.isFileExists(
        item.downloadModel.songId,
      );
      if (exists) {
        validDownload.add(item);
      }
    }

    downloads.assignAll(validDownload);

    await saveLocalDownloads();
  }
}
