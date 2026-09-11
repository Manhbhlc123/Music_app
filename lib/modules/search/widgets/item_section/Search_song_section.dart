import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/modules/search/widgets/Item_card/Search_song_card.dart';

class SearchSongSection extends StatelessWidget {
  final List<SongItemModel> songs;

  const SearchSongSection({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (_, index) => SearchSongCard(songItemModel: songs[index]),
      separatorBuilder: (_, _) => const SizedBox(height: 5),
      itemCount: songs.length,
    );
  }
}
