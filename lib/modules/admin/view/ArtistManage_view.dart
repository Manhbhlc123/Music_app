import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';
import 'package:sq_mp3/modules/admin/widget/ArtistManagement_widget/Artist_section.dart';

class ArtistManageView extends GetView<AdminController> {
  const ArtistManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artist Management", style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.createArtistFromAdminPage);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ArtistSectionAdmin(
          listArtist: controller.artists,
          onEdit: controller.updateArtist,
          onRemove: controller.deleteArtist,
        );
      }),
    );
  }
}
