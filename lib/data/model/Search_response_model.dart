import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class SearchResponseModel {
  final List<SongItemModel> songs;
  final List<ArtistModel> artists;
  final List<AlbumModel> albums;
  final List<PlaylistModel> playlists;

  SearchResponseModel({
    required this.songs,
    required this.artists,
    required this.albums,
    required this.playlists,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      songs: (json["songs"] as List? ?? [])
          .map((e) => SongItemModel.fromJson(e))
          .toList(),

      artists: (json["artists"] as List? ?? [])
          .map((e) => ArtistModel.fromJson(e))
          .toList(),

      albums: (json["albums"] as List? ?? [])
          .map((e) => AlbumModel.fromJson(e))
          .toList(),

      playlists: (json["playlists"] as List? ?? [])
          .map((e) => PlaylistModel.fromJson(e))
          .toList(),
    );
  }
}