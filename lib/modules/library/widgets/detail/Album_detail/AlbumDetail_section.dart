import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/modules/home/widgets/PlaylistDetail_widget/playlistDetail_item.dart';
import 'package:sq_mp3/modules/library/widgets/detail/Album_detail/AlbumDetail_item.dart';

class AlbumDetailSection extends StatelessWidget
{
  final List<SongItemModel> songs;
  // final VoidCallback onRemove;

  const AlbumDetailSection({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index){
      SongItemModel song = songs[index];

      return AlbumDetailItem(songItemModel: song);

    }, itemCount: songs.length,);
  }


}