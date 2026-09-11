import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/Song_card.dart';

class RecommentSongSection extends StatelessWidget {
  final List<SongItemModel> songs;

  const RecommentSongSection({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (_, index) {
          return SongCard(songModel: songs[index]);
        },
        separatorBuilder: (_, _) => const SizedBox(width: 15),
        itemCount: songs.length,
      ),
    );
  }
}
