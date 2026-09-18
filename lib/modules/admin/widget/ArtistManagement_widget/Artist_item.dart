import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/admin/widget/AlbumManagement_widget/UpdateAlbum_dialog.dart';
import 'package:sq_mp3/modules/admin/widget/ArtistManagement_widget/UpdateArtist_dialog.dart';
import 'package:sq_mp3/modules/admin/widget/SongManagement_widget/UpdateSong_dialog.dart';

class ArtistItemAdmin extends StatelessWidget {
  final ArtistModel artistModel;

  final Function(ArtistModel)? onUpdate;
  final VoidCallback? onDelete;

  const ArtistItemAdmin({
    super.key,
    required this.artistModel,
    this.onUpdate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: artistModel.avatarUrl.isNotEmpty
            ? NetworkImage(artistModel.avatarUrl)
            : null,
        child: artistModel.avatarUrl.isEmpty
            ? Text(artistModel.name[0].toUpperCase())
            : null,
      ),
      title: Row(
        children: [
          Text(artistModel.name),
          if (artistModel.verify)
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Icon(Icons.verified, size: 16, color: Colors.blue),
            ),
        ],
      ),
      subtitle: artistModel.country.isNotEmpty ? Text(artistModel.country) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              final updateArtist = await showDialog<ArtistModel>(
                context: context,
                builder: (context) {
                  return UpdateArtistDialog(artistModel: artistModel);
                },
              );
              if (updateArtist != null) {
                onUpdate?.call(updateArtist);
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
                    "Are you sure you want to delete ${artistModel.name}?",
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
