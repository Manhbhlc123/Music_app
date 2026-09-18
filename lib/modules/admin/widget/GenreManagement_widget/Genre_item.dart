import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/model/genre_model.dart';
import 'package:sq_mp3/modules/admin/widget/AlbumManagement_widget/UpdateAlbum_dialog.dart';
import 'package:sq_mp3/modules/admin/widget/ArtistManagement_widget/UpdateArtist_dialog.dart';
import 'package:sq_mp3/modules/admin/widget/GenreManagement_widget/UpdateGenre_dialog.dart';
import 'package:sq_mp3/modules/admin/widget/SongManagement_widget/UpdateSong_dialog.dart';

class GenreItemAdmin extends StatelessWidget {
  final GenresModel genresModel;

  final Function(GenresModel)? onUpdate;
  final VoidCallback? onDelete;

  const GenreItemAdmin({
    super.key,
    required this.genresModel,
    this.onUpdate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: genresModel.coverUrl.isNotEmpty
            ? NetworkImage(genresModel.coverUrl)
            : null,
        child: genresModel.coverUrl.isEmpty
            ? Text(genresModel.name[0].toUpperCase())
            : null,
      ),
      title: Text(genresModel.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              final updateGenre = await showDialog<GenresModel>(
                context: context,
                builder: (context) {
                  return UpdateGenreDialog(genresModel: genresModel);
                },
              );
              if (updateGenre != null) {
                onUpdate?.call(updateGenre);
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
                    "Are you sure you want to delete ${genresModel.name}?",
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
