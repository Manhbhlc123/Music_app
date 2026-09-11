import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/home/controller/Home_controller.dart';
import 'package:sq_mp3/modules/home/view/Home_page.dart';
import 'package:sq_mp3/modules/library/view/Library_view.dart';
import 'package:sq_mp3/modules/player/widges/PlayerMiniBar.dart';
import 'package:sq_mp3/modules/profile/view/Profile_view.dart';
import 'package:sq_mp3/modules/search/views/Search_view.dart';

import 'favorite/view/Favorite_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentindex.value,
          children: [
            HomePage(),
            SearchView(),
            FavoriteView(),
            LibraryView(),
            ProfileView(),
          ],
        ),
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PlayerMiniBar(),
          Obx(
            () => BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_music),
                  label: "Library",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Person",
                ),
              ],
              currentIndex: controller.currentindex.value,
              onTap: (index) => controller.currentindex.value = index,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ],
      ),
    );
  }
}
