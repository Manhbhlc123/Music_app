import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';
import 'package:sq_mp3/modules/library/widgets/Download/Download_section.dart';

class DownloadView extends GetView<LibraryController> {
  const DownloadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Downloads"), centerTitle: true),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),

          Obx(
            () => Align(
              alignment: AlignmentGeometry.center,
              child: Text(
                "số lượt tải còn lại trong tháng này là: ${controller.remainingDownloads.value}", style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.downloads.isEmpty) {
                return const Center(child: Text("No downloads yet"));
              }
              return DownloadSection(downloads: controller.downloads.value);
            }),
          ),
        ],
      ),
    );
  }
}
