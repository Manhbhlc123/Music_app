import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/Playlist_card.dart';

class PlaylistSection extends StatelessWidget {
  final List<PlaylistModel> playlists;

  const PlaylistSection({super.key, required this.playlists});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (_, index) {
          return PlaylistCard(playlistModel: playlists[index]);
        },
        separatorBuilder: (_, _) => const SizedBox(width: 15),
        itemCount: playlists.length,
      ),
    );
  }
}
