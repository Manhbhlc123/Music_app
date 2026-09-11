import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/modules/search/widgets/Item_card/Search_artist_card.dart';

class SearchArtistSection extends StatelessWidget {
  final List<ArtistModel> artists;

  const SearchArtistSection({required this.artists, super.key});

  @override
  Widget build(BuildContext context) {
    if (artists.isEmpty) {
      return const Center(child: Text("Không tìm thấy nghệ sĩ nào"));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: artists.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return SearchArtistCard(artist: artists[index]);
      },
    );
  }
}
