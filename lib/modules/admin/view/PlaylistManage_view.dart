import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';

class PlaylistManageView extends GetView<AdminController> {
  const PlaylistManageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PLaylist Management',
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
      // body: Obx(() => ListView.builder(
      //   itemCount: controller.genres.length,
      //   itemBuilder: (context, index) {
      //     final genre = controller.genres[index];
      //     return ListTile(
      //       title: Text(genre.name),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.delete),
      //         onPressed: () => controller.deleteGenre(genre.id),
      //       ),
      //     );
      //   },
      // )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => controller.addGenre(),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
