import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';
import 'package:sq_mp3/modules/admin/widget/GenreManagement_widget/Genre_section.dart';

class GenreManageView extends GetView<AdminController> {
  const GenreManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Genre Management", style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.createGenreFromAdminPage);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Obx((){
        if(controller.isLoading.value)
          {
            return Center(child: CircularProgressIndicator(),);
          }
        return GenresSectionAdmin(listGenres: controller.genres, onEdit: controller.updateGenre, onRemove: controller.deleteGenre);
      }),
    );
  }
}
