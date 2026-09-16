import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';
import 'package:sq_mp3/modules/admin/widget/PlaylistManagement_widget/Playlist_section.dart';

class PlaylistManageView extends GetView<AdminController> {
  const PlaylistManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Playlist Management',
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.createPlaylistFromAdminPage);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return PlaylistSectionAdmin(
          listPlaylist: controller.playlists,
          onEdit: controller.updatePlaylist,
          onRemove: controller.deletePlaylist,
        );
      }),
    );
  }
}
