import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/modules/player/controller/Player_controller.dart';

class PlaylistDetailItem extends StatelessWidget {
  final SongItemModel songItemModel;
  final VoidCallback onRemove;

  const PlaylistDetailItem({super.key, required this.songItemModel, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        final playerController = Get.find<PlayerController>();
        playerController.playSong(songItemModel);
        Get.toNamed(Routes.playerView);
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: songItemModel.coverUrl,
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
        songItemModel.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(songItemModel.artistName, style: TextStyle(color: Colors.grey.shade400)),

      trailing: IconButton(
        onPressed: (){
          onRemove();
        },
        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
      ),
    );
  }
}
