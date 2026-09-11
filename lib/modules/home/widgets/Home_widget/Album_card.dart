import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Album_model.dart';

class AlbumCard extends StatelessWidget {
  final AlbumModel albumModel;

  const AlbumCard({super.key, required this.albumModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: albumModel.cover,
              width: 170,
              height: 170,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                width: 170,
                height: 170,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.music_note),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            albumModel.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
