import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';
import 'package:sq_mp3/modules/library/widgets/Album/Album_section.dart';

class Album extends GetView<LibraryController> {
  const Album({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Album",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20,),
          Expanded(child: Obx((){
            if(controller.albums.isEmpty)
              {
                return Center(child: Text("No album yet"),);
              }
            return AlbumSectionLibrary(albums: controller.albums.toList(), onRemove: controller.removeAlbum,);
          }))
        ],
      ),
    );
  }
}
