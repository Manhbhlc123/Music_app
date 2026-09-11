import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/SongOfArtistDetail_widget/SongsOfArtist_item.dart';
import 'package:sq_mp3/modules/home/widgets/PlaylistDetail_widget/playlistDetail_item.dart';

class SongsofartistSection extends StatelessWidget
{
  final List<SongItemModel> songs;
  // final VoidCallback onRemove;

  const SongsofartistSection({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index){
      SongItemModel song = songs[index];

      return SongsofartistItem(songItemModel: song);

    }, itemCount: songs.length,);
  }


}