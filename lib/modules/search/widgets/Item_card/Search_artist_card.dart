import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';

class SearchArtistCard extends StatelessWidget
{
  final ArtistModel artist;

  const SearchArtistCard({required this.artist, super.key});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          artist.avatarUrl,
        ),
        backgroundColor: Colors.white70,
      ),
      title: Text(
        artist.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("${artist.followerCount} người theo dõi"),
      onTap: () {
        // Navigator.pushNamed(context, Routes.searchResult, arguments: artists[index]);
      },
    );
  }

}