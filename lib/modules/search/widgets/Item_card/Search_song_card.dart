import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class SearchSongCard extends StatelessWidget
{
  final SongItemModel songItemModel;

  const SearchSongCard({super.key, required this.songItemModel});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(songItemModel.coverUrl), backgroundColor: Colors.white70,),
      title: Text(songItemModel.title, style: const TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Text(songItemModel.artistName),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {},
      ),
      onTap: () {},
    );
  }

}