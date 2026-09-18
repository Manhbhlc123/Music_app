import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class ArtistCreateRequest {
  final String name;
  final String bio;
  final String avatarUrl;
  final String country;
  List<SongItemModel> topSongs;
  List<AlbumModel> albums;

  ArtistCreateRequest({
    required this.name,
    required this.bio,
    required this.avatarUrl,
    required this.country,
    required this.topSongs,
    required this.albums,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'avatarUrl': avatarUrl,
      'country': country,
      'topSongs': topSongs.map((x) => x.toJson()).toList(),
      'albums': albums.map((x) => x.toJson()).toList(),
    };
  }
}
