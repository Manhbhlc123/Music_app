import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/modules/search/widgets/Item_card/Search_playlist_card.dart';

class SearchPlaylistSection extends StatelessWidget {
  final List<PlaylistModel> playlists;

  const SearchPlaylistSection({super.key, required this.playlists});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: playlists.length,
          itemBuilder: (context, index) =>
              SearchPlaylistCard(playlist: playlists[index]),
    );
  }
}
