import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';

class MyPlaylistItemLibrary extends StatelessWidget {
  final PlaylistModel playlistModel;
  final VoidCallback onRemove;

  const MyPlaylistItemLibrary({
    super.key,
    required this.playlistModel,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.toNamed(
          Routes.playlistDetail,
          arguments: {
            'playlistName': playlistModel.title,
            'playlistId': playlistModel.id,
          },
        );
      },

      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: playlistModel.coverUrl,
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
        playlistModel.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "${playlistModel.totalSong} songs",
        style: TextStyle(color: Colors.grey.shade400),
      ),

      trailing: IconButton(
        onPressed: onRemove,
        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
      ),
    );
  }
}
