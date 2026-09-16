import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/admin/widget/AlbumManagement_widget/UpdateAlbum_dialog.dart';
import 'package:sq_mp3/modules/admin/widget/PlaylistManagement_widget/UpdatePlaylist_dialog.dart';
import 'package:sq_mp3/modules/admin/widget/SongManagement_widget/UpdateSong_dialog.dart';

class PlaylistItemAdmin extends StatelessWidget {
  final PlaylistModel playlistModel;

  final Function(PlaylistModel)? onUpdate;
  final VoidCallback? onDelete;

  const PlaylistItemAdmin({
    super.key,
    required this.playlistModel,
    this.onUpdate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: playlistModel.coverUrl.isNotEmpty
            ? NetworkImage(playlistModel.coverUrl)
            : null,
        child: playlistModel.coverUrl.isEmpty
            ? Text(playlistModel.title[0].toUpperCase())
            : null,
      ),
      title: Text(playlistModel.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              final updatedPlaylist = await showDialog<PlaylistModel>(
                context: context,
                builder: (context) {
                  return UpdatePlaylistDialog(playlistModel: playlistModel);
                },
              );
              if (updatedPlaylist != null) {
                onUpdate?.call(updatedPlaylist);
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
                    "Are you sure you want to delete ${playlistModel.title}?",
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
