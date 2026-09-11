import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';

class SearchPlaylistCard extends StatelessWidget
{
  final PlaylistModel playlist;
  
  const SearchPlaylistCard({super.key, required this.playlist});
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(image: CachedNetworkImageProvider(playlist.coverUrl), width: 70, height: 70, fit: BoxFit.cover,),
      title: Text(playlist.title, style: const TextStyle(fontWeight: FontWeight.bold),),
    );
  }
  
}