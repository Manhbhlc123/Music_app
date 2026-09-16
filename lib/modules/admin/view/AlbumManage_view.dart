import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';
import 'package:sq_mp3/modules/admin/widget/AlbumManagement_widget/Album_section.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/Album_section.dart';

class AlbumManageView extends GetView<AdminController> {
  const AlbumManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Album Management",
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.createAlbumFromAdminPage);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return AlbumSectionAdmin(
          listAlbum: controller.albums,
          onEdit: (album) => controller.updateAlbum(album),
          onRemove: (albumId) => controller.deleteAlbum(albumId),
        );
      }),
    );
  }
}
