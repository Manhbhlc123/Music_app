import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';
import 'package:sq_mp3/modules/admin/widget/SongManagement_widget/Song_section.dart';

class SongManageView extends GetView<AdminController> {
  const SongManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Song Management",
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Obx(() => controller.isLoading.value ? CircularProgressIndicator() : SongSection(listSongs: controller.songs, onEdit: controller.updateSong, onRemove: controller.deleteSong)),
    );
  }
}
