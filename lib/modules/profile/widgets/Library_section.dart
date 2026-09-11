import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/Favorite_model.dart';

class LibrarySection extends StatelessWidget
{
  final List<FavoriteModel> favorite;
  final List<ArtistModel> artists;

  const LibrarySection({super.key, required this.favorite, required this.artists});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(); // TODO: Implement item widget
      },
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      itemCount: artists.length,
    );
  }

}
