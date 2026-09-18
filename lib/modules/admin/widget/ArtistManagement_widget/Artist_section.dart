import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/modules/admin/widget/AlbumManagement_widget/Album_item.dart';
import 'package:sq_mp3/modules/admin/widget/ArtistManagement_widget/Artist_item.dart';

class ArtistSectionAdmin extends StatelessWidget {
  final List<ArtistModel> listArtist;
  final Function(ArtistModel artist) onEdit;
  final Function(String artistId) onRemove;

  const ArtistSectionAdmin({
    super.key,
    required this.listArtist,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        ArtistModel artistModel = listArtist[index];
        return ArtistItemAdmin(
          artistModel: artistModel,
          onUpdate: (artistModel) => onEdit(artistModel),
          onDelete: () => onRemove(artistModel.id),
        );
      },
      itemCount: listArtist.length,
    );
  }
}
