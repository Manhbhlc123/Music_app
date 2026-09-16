import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/modules/admin/widget/AlbumManagement_widget/Album_item.dart';

class AlbumSectionAdmin extends StatelessWidget {
  final List<AlbumModel> listAlbum;
  final Function(AlbumModel album) onEdit;
  final Function(String albumId) onRemove;

  const AlbumSectionAdmin({
    super.key,
    required this.listAlbum,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        AlbumModel albumModel = listAlbum[index];
        return AlbumItemAdmin(
          albumModel: albumModel,
          onUpdate: (albumModel) => onEdit(albumModel),
          onDelete: () => onRemove(albumModel.id),
        );
      },
      itemCount: listAlbum.length,
    );
  }
}
