import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';

class AlbumItem extends StatelessWidget {
  final AlbumModel albumModel;
  final VoidCallback onRemove;

  const AlbumItem({
    super.key,
    required this.albumModel,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final libraryController = Get.find<LibraryController>();
        await libraryController.loadSongOfAlbum(albumModel.id);
        Get.toNamed(Routes.albumDetail, arguments: albumModel.title);
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: albumModel.cover,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          placeholder: (_, _) {
            return Container(
              width: double.infinity,
              height: 330,
              color: Colors.grey.shade900,
              child: const Icon(
                Icons.music_note,
                color: Colors.white,
                size: 80,
              ),
            );
          },

          errorWidget: (_, _, _) {
            return Container(
              width: double.infinity,
              height: 330,
              color: Colors.grey.shade900,
              child: const Icon(
                Icons.music_note,
                color: Colors.white,
                size: 80,
              ),
            );
          },
        ),
      ),

      title: Text(
        albumModel.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Artist', style: TextStyle(color: Colors.grey.shade400)),

      trailing: IconButton(onPressed: onRemove, icon: Icon(Icons.remove)),
    );
  }
}
