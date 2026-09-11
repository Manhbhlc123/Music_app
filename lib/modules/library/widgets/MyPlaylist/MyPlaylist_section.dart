import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/modules/library/widgets/Album/Album_item.dart';
import 'package:sq_mp3/modules/library/widgets/MyPlaylist/MyPlaylist_item.dart';

class MyPlaylistSectionLibrary extends StatelessWidget {
  final List<PlaylistModel> playlists;
  final Function(String playlistId) onRemove;

  const MyPlaylistSectionLibrary({
    super.key,
    required this.playlists,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        PlaylistModel playlist = playlists[index];

        return MyPlaylistItemLibrary(
          playlistModel: playlist,
          onRemove: () => onRemove(playlist.id),
        );
      },
      itemCount: playlists.length,
    );
  }
}
