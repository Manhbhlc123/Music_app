import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/search/controller/Search_controller.dart';
import 'package:sq_mp3/modules/search/widgets/item_section/Search_album_section.dart';
import 'package:sq_mp3/modules/search/widgets/item_section/Search_artist_section.dart';
import 'package:sq_mp3/modules/search/widgets/item_section/Search_playlist_section.dart';
import 'package:sq_mp3/modules/search/widgets/item_section/Search_song_section.dart';

class SearchResultPage extends GetView<SearchControllerHome> {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Results')),
      body: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TabBar(
                isScrollable: false,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Bài hát"),
                  Tab(text: "Playlist"),
                  Tab(text: "Nghệ sĩ"),
                  Tab(text: "Album"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Obx(() => SearchSongSection(songs: controller.songs.value)),
                    Obx(
                      () => SearchPlaylistSection(
                        playlists: controller.playlists.value,
                      ),
                    ),
                    Obx(
                      () => SearchArtistSection(
                        artists: controller.artists.value,
                      ),
                    ),
                    Obx(
                      () => SearchAlbumSection(albums: controller.albums.value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
