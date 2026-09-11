import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/modules/home/widgets/PlaylistDetail_widget/playlistDetail_item.dart';

class PlaylistDetailSection extends StatelessWidget
{
  final List<SongItemModel> songs;
  final Function(String songId) onRemove;

  const PlaylistDetailSection({super.key, required this.songs, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index){
      SongItemModel song = songs[index];

      return PlaylistDetailItem(songItemModel: song, onRemove: () => onRemove(song.id),);

    }, itemCount: songs.length,);
  }


}