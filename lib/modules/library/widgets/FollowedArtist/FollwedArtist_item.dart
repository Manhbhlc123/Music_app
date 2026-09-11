import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
class FollowedArtistItem extends StatelessWidget {
  final ArtistModel artistModel;
  final VoidCallback onFollow;

  const FollowedArtistItem({
    super.key,
    required this.artistModel,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.toNamed(
          Routes.songsOfArtist,
          arguments: {
            'artistId': artistModel.id,
            'artistName': artistModel.name,
          },
        );
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: artistModel.avatarUrl,
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
        artistModel.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Artist', style: TextStyle(color: Colors.grey.shade400)),

      trailing: IconButton(
        onPressed: onFollow,
        icon: Icon(Icons.person_remove_rounded),
      ),
    );
  }
}
