import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/player/controller/Player_controller.dart';
import 'package:sq_mp3/modules/player/view/Lyrics_view.dart';
import 'package:sq_mp3/modules/player/view/PlayerContent_view.dart';
import 'package:sq_mp3/modules/player/widges/QueueBottomSheet.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<StatefulWidget> createState() => _PlayerViewState();
}


class _PlayerViewState extends State<PlayerView> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("Đang phát", style: TextStyle(color: Colors.white)),

        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                const QueueBottomSheet(),
                backgroundColor: Colors.white,
              );
            },
            icon: Icon(Icons.queue_music),
          ),
        ],
      ),

      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: const [PlayerContent(), LyricsView()],
      ),
    );
  }
}
