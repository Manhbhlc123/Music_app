import 'dart:convert';
import 'package:sq_mp3/core/network/api_client.dart';
import 'package:sq_mp3/data/model/BaseUrlApi_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class PlaylistProvider {
  final String baseUrl = BaseUrlApiModel().baseUrl;
  final api = ApiClient();

  //func getPlaylist home
  Future<List<PlaylistModel>> getPlaylistHome(String token) async {
    try {
      final url = Uri.parse("$baseUrl/playlists/getPlaylistHome");
      final response = await api
          .get(url, {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token",
          })
          .timeout(const Duration(seconds: 15));

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (json["result"] as List)
            .map((e) => PlaylistModel.fromJson(e))
            .toList();
      } else {
        throw Exception(
          "Failed to load system playlists: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching system playlists: $e");
      rethrow;
    }
  }

  //func get user playlists
  Future<List<PlaylistModel>> getUserPlaylists(String token) async {
    try {
      final url = Uri.parse("$baseUrl/playlists/getMyPlaylist");
      final response = await api
          .get(url, {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token",
          })
          .timeout(const Duration(seconds: 5));

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (json["result"] as List)
            .map((e) => PlaylistModel.fromJson(e))
            .toList();
      } else {
        throw Exception(
          "Failed to load user playlists: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching user playlists: $e");
      rethrow;
    }
  }

  //get song of Playlist
  Future<List<SongItemModel>> getSongOfPlaylistSystem(
    String token,
    String playlistId,
  ) async {
    try {
      final url = Uri.parse("${baseUrl}/playlists/${playlistId}/songs");

      final response = await api.get(url, {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return (json['result'] as List)
            .map((e) => SongItemModel.fromJson(e))
            .toList();
      } else {
        throw Exception(
          "Failed to load song of playlist($playlistId): ${response.statusCode}",
        );
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  //add song to playlist
  Future<String> addSongToPlaylist(
    String token,
    String songId,
    String playlistId,
  ) async {
    final url = Uri.parse("$baseUrl/playlists/my/$playlistId/songs/$songId");

    final response = await api.post(url, {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    }, null);

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);

      return json['message'] ?? "Success";
    }

    throw Exception("HTTP ${response.statusCode}: ${response.body}");
  }

  Future<String> deletePlaylist(String token, String playlistId) async {
    try {
      final url = Uri.parse("$baseUrl/playlists/$playlistId");

      final response = await api
          .delete(url, {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          })
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return json['message'];
      } else {
        throw Exception("Can't remove playlist: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getPlaylistCount(String token) async
  {
    final url = Uri.parse("$baseUrl/playlists/count");
    final response = await api.get(url, {
      "Authorization": "Bearer $token",
    }).timeout(Duration(seconds: 5));

    if(response.statusCode == 200)
    {
      final json = jsonDecode(response.body);
      return json['result'] as int;
    }
    else {
      throw Exception("Failed to load playlist count");
    }
  }
}
