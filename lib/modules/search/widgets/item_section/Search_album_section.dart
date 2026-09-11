import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/modules/search/widgets/Item_card/Search_album_card.dart';

class SearchAlbumSection extends StatelessWidget {
  final List<AlbumModel> albums;

  const SearchAlbumSection({required this.albums, super.key});

  @override
  Widget build(BuildContext context) {
    if (albums.isEmpty) {
      return const Center(child: Text("Không tìm thấy album nào"));
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (_, index) => SearchAlbumCard(album: albums[index]),
      separatorBuilder: (_, _) => const SizedBox(height: 5),
      itemCount: albums.length,
    );
  }
}
