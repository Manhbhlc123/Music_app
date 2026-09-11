import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/home/controller/Home_controller.dart';
import 'package:sq_mp3/modules/home/widgets/Home_ui/Banner_slider.dart';
import 'package:sq_mp3/modules/home/widgets/Home_ui/Home_search_bar.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/Artist_section.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/Recent_song_section.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/Recomment_song_section.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/playlist_section.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/Section_title.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                title: Obx(
                      () => Text("Xin Chào ${controller.userName.value}"),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 15),

                    const HomeSearchBar(),
                    const SizedBox(height: 25),

                    Obx(() {
                      if (controller.loading.value) {
                        return const CircularProgressIndicator();
                      }
                      return BannerSlider(banners: controller.banners);
                    }),
                    const SizedBox(height: 25),

                    const SectionTitle(title: "Có thể bạn sẽ thích"),
                    const SizedBox(height: 15),
                    Obx(() {
                      return RecommentSongSection(
                        songs: controller.recommendSongs.value,
                      );
                    }),
                    const SizedBox(height: 25),

                    const SectionTitle(title: "Playlist"),
                    const SizedBox(height: 15),
                    Obx(() {
                      return PlaylistSection(
                        playlists: controller.playlists.value,
                      );
                    }),

                    const SizedBox(height: 25),
                    const SectionTitle(title: "Nghệ sĩ"),
                    const SizedBox(height: 15),
                    Obx(() {
                      return ArtistSection(
                        artistModels: controller.artists.value,
                      );
                    }),

                    Obx(() {
                      return controller.recentSongs.isNotEmpty
                          ? Column(
                              children: [
                                const SizedBox(height: 30),
                                const SectionTitle(title: "Nghe gần đây"),
                                const SizedBox(height: 10),
                                RecentSongSection(songs: controller.recentSongs.value),
                              ],
                            )
                          : const SizedBox.shrink();
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          onRefresh: () => controller.loadHome(),
        ),
      ),
    );
  }
}
