import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/modules/admin/widget/SongManagement_widget/Song_item.dart';

class SongSection extends StatelessWidget {
  final List<SongItemModel> listSongs;
  final Function(SongItemModel song) onEdit;
  final Function(String songId) onRemove;

  const SongSection({
    super.key,
    required this.listSongs,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        SongItemModel song = listSongs[index];
        return SongItem(
          song: song,
          onUpdate: (updateSong) => onEdit(updateSong),
          onDelete: () => onRemove(song.id),
        );
      },
      itemCount: listSongs.length,
    );
  }
}
