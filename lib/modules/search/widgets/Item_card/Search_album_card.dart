import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Album_model.dart';

class SearchAlbumCard extends StatelessWidget {
  final AlbumModel album;

  const SearchAlbumCard({required this.album, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        child: CachedNetworkImage(
          imageUrl: album.cover,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(
            width: 50,
            height: 50,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.music_note),
        ),
      ),
      title: Text(
        album.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () {
        // Navigator.pushNamed(context, Routes.searchResult, arguments: artists[index]);
      },
    );
  }
}
