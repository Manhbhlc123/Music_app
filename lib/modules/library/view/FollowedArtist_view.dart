import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';
import 'package:sq_mp3/modules/library/widgets/FollowedArtist/FollwedArtist_section.dart';

class FollowedArtist extends GetView<LibraryController> {
  const FollowedArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorited Artist"), centerTitle: true),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (controller.followedArtist.isEmpty) {
                return const Center(child: Text("No favorited artists yet"));
              }
              return FollowedArtistSection(
                artists: controller.followedArtist,
                onFollow: controller.toggleFollowArtist,
              );
            }),
          ),
        ],
      ),
    );
  }
}
