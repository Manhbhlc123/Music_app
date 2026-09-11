import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/home/binding/PlaylistDetail_controller.dart';
import 'package:sq_mp3/modules/home/controller/Home_controller.dart';
import 'package:sq_mp3/modules/home/widgets/PlaylistDetail_widget/PlaylistDetail_section.dart';

class PlaylistDetailView extends GetView<PlaylistDetailController> {
  const PlaylistDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Get.arguments['playlistName'] ?? "songs of album"), centerTitle: true),

      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.songOfPlaylistSystem.isEmpty) {
                return const Center(
                  child: Text("No songs in this playlist yet"),
                );
              }
              return PlaylistDetailSection(
                songs: controller.songOfPlaylistSystem,
                onRemove: controller.deleteSong,
              );
            }),
          ),
        ],
      ),
    );
  }
}
