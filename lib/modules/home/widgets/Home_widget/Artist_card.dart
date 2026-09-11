import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';

class ArtistCard extends StatelessWidget {
  final ArtistModel artistModel;

  const ArtistCard({
    super.key,
    required this.artistModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(artistModel.id);

        Get.toNamed(
          Routes.songsOfArtist,
          arguments: {
            'artistName': artistModel.name,
            'artistId': artistModel.id
          },
        );
      },
      child: SizedBox(
        width: 100,
        height: 170,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: CachedNetworkImageProvider(
                artistModel.avatarUrl,
                maxHeight: 80,
                maxWidth: 80,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              artistModel.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}