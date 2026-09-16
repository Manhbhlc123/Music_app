import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/admin/widget/AlbumManagement_widget/UpdateAlbum_dialog.dart';
import 'package:sq_mp3/modules/admin/widget/SongManagement_widget/UpdateSong_dialog.dart';

class AlbumItemAdmin extends StatelessWidget {
  final AlbumModel albumModel;

  final Function(AlbumModel)? onUpdate;
  final VoidCallback? onDelete;

  const AlbumItemAdmin({
    super.key,
    required this.albumModel,
    this.onUpdate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: albumModel.cover.isNotEmpty
            ? NetworkImage(albumModel.cover)
            : null,
        child: albumModel.cover.isEmpty
            ? Text(albumModel.title[0].toUpperCase())
            : null,
      ),
      title: Text(albumModel.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              final updateAlbum = await showDialog<AlbumModel>(
                context: context,
                builder: (context) {
                  return UpdateAlbumDialog(albumModel: albumModel,);
                },
              );
              if (updateAlbum != null) {
                onUpdate?.call(updateAlbum);
              }
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("Confirm Delete"),
                  content: Text(
                    "Are you sure you want to delete ${albumModel.title}?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        onDelete?.call();
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
