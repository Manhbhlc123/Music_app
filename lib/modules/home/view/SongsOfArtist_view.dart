import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/home/controller/SongsOfArtist_controller.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/SongOfArtistDetail_widget/SongsOfArtist_section.dart';

class SongsofartistView extends GetView<SongsOfArtistController> {
  const SongsofartistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['artistName'] ?? "songs of artist"),
        centerTitle: true,
        actions: [
          Obx(() {
            return IconButton(
              onPressed: () {
                controller.followArtist();
              },
              icon: controller.checkState.value
                  ? Icon(Icons.person_remove_rounded)
                  : Icon(Icons.person_add_alt_1_rounded),
            );
          }),
        ],
      ),

      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              print(controller.songs.length);

              if (controller.songs.isEmpty) {
                return const Center(child: Text("No songs of this artist yet"));
              }
              return SongsofartistSection(songs: controller.songs);
            }),
          ),
        ],
      ),
    );
  }
}
