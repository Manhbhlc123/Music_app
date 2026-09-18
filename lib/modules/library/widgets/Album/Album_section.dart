import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/modules/library/widgets/Album/Album_item.dart';

class AlbumSectionLibrary extends StatelessWidget
{
  final List<AlbumModel> albums;
  final Function(String albumId) onRemove;

  const AlbumSectionLibrary({super.key, required this.albums, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        AlbumModel album = albums[index];
        return AlbumItem(
          albumModel: album,
          onRemove: onRemove,
        );
      },
    );
  }


}