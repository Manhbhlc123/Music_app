import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/modules/home/controller/Home_controller.dart';

class PlaylistCard extends StatelessWidget {
  final PlaylistModel playlistModel;

  PlaylistCard({super.key, required this.playlistModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        Get.toNamed(Routes.playlistDetail, arguments: {
          'playlistName': playlistModel.title,
          'playlistId': playlistModel.id
        });
        },
      child: SizedBox(
        width: 170,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: playlistModel.coverUrl,
                width: 170,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 10),

            Text(
              playlistModel.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            Text(
              "${playlistModel.totalSong} bài hát",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
