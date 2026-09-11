import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/Album_card.dart';

class AlbumSection extends StatelessWidget {
  final List<AlbumModel> albumModels;

  const AlbumSection({super.key, required this.albumModels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return AlbumCard(albumModel: albumModels[index]);
        },
        separatorBuilder: (_, _) => const SizedBox(width: 15),
        itemCount: albumModels.length,
      ),
    );
  }
}
