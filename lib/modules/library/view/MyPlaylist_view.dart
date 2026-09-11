import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';
import 'package:sq_mp3/modules/library/widgets/MyPlaylist/MyPlaylist_item.dart';
import 'package:sq_mp3/modules/library/widgets/MyPlaylist/MyPlaylist_section.dart';

class MyPlaylistView extends GetView<LibraryController> {

  const MyPlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Playlist",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (controller.playlists.isEmpty) {
                return Center(child: Text("No playlist yet"));
              }
              return MyPlaylistSectionLibrary(
                playlists: controller.playlists,
                onRemove: controller.removePlaylist,
              );
            }),
          ),
        ],
      ),
    );
  }
}
