import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/player/controller/Player_controller.dart';

class LyricsView extends StatefulWidget {
  const LyricsView({super.key});

  @override
  State<LyricsView> createState() => _LyricsViewState();
}
class _LyricsViewState extends State<LyricsView> {
  final controller = Get.find<PlayerController>();

  final ScrollController scrollController =
  ScrollController();

  int previousIndex = -1;

  @override
  void initState() {
    super.initState();

    ever(
      controller.currentLyricIndex,
          (index) {
        if (index != previousIndex) {
          previousIndex = index;
          scrollToLyric(index);
        }
      },
    );
  }

  void scrollToLyric(int index) {
    if (!scrollController.hasClients) return;

    final position = index * 60.0;

    scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 100,
          ),
          itemCount: controller.lyrics.length,
          itemBuilder: (context, index) {
            final lyric = controller.lyrics[index];

            final isCurrent =
                index == controller.currentLyricIndex.value;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                lyric.lineText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isCurrent ? 25 : 18,
                  fontWeight: isCurrent
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: isCurrent
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}