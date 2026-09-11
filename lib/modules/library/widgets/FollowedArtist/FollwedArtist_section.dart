import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/modules/library/widgets/FollowedArtist/FollwedArtist_item.dart';

class FollowedArtistSection extends StatelessWidget {
  final List<ArtistModel> artists;
  final Function(ArtistModel) onFollow;

  const FollowedArtistSection({
    super.key,
    required this.artists,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return FollowedArtistItem(
          artistModel: artist,
          onFollow: () {
            onFollow(artist);
          },
        );
      },
    );
  }
}
