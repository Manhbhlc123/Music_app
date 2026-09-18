import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/admin/widget/SongManagement_widget/UpdateSong_dialog.dart';

class SongItem extends StatelessWidget {
  final SongItemModel song;

  final Function(SongItemModel)? onUpdate;
  final VoidCallback? onDelete;

  const SongItem({
    super.key,
    required this.song,
    this.onUpdate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundImage: song.coverUrl.isNotEmpty
            ? NetworkImage(song.coverUrl)
            : null,
        child: song.coverUrl.isEmpty
            ? Text(song.title[0].toUpperCase())
            : null,
      ),
      title: Text(song.title),
      subtitle: Text(song.artistName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              final updatedSong = await showDialog<SongItemModel>(
                context: context,
                builder: (context) {
                  return UpdateSongDialog(song: song,);
                },
              );
              if (updatedSong != null) {
                onUpdate?.call(updatedSong);
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
                    "Are you sure you want to delete ${song.title}?",
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
