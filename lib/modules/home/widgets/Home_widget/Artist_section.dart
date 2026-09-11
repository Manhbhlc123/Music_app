import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/Artist_card.dart';

class ArtistSection extends StatelessWidget {
  final List<ArtistModel> artistModels;

  const ArtistSection({super.key, required this.artistModels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return ArtistCard(artistModel: artistModels[index]);
        },
        separatorBuilder: (_, _) => const SizedBox(width: 15),
        itemCount: artistModels.length,
      ),
    );
  }
}
