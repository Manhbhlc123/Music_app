import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';
import 'package:sq_mp3/modules/library/widgets/detail/Album_detail/AlbumDetail_section.dart';

class AlbumDetailView extends GetView<LibraryController>
{
  const AlbumDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments ?? "Album songs", style: const TextStyle(color: Colors.white),),
        centerTitle: true,
      ),

      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Obx(() {
              if(controller.songOfAlbum.isEmpty)
                {
                  return const Center(child: Text("No song of Album yet"),);
                }
              return AlbumDetailSection(songs: controller.songOfAlbum);
            }),
          ),
        ],
      ),
    );
  }

}