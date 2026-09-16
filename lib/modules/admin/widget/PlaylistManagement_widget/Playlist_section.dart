import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/modules/admin/widget/AlbumManagement_widget/Album_item.dart';
import 'package:sq_mp3/modules/admin/widget/PlaylistManagement_widget/Playlist_item.dart';

class PlaylistSectionAdmin extends StatelessWidget {
  final List<PlaylistModel> listPlaylist;
  final Function(PlaylistModel playlist) onEdit;
  final Function(String albumId) onRemove;

  const PlaylistSectionAdmin({
    super.key,
    required this.listPlaylist,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        PlaylistModel playlistModel = listPlaylist[index];
        return PlaylistItemAdmin(
          playlistModel: playlistModel,
          onUpdate: (playlistModel) => onEdit(playlistModel),
          onDelete: () => onRemove(playlistModel.id),
        );
      },
      itemCount: listPlaylist.length,
    );
  }
}
