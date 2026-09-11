import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/player/controller/Player_controller.dart';
import 'package:sq_mp3/modules/player/view/Play_view.dart';

class PlayerMiniBar extends GetView<PlayerController> {

  const PlayerMiniBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final song = controller.currentSong.value;

      //chưa có bài hát
      if (song == null) {
        return const SizedBox.shrink();
      }

      return GestureDetector(
        onTap: () {
          Get.to(() => const PlayerView());
        },
        child: Container(
          height: 68,
          padding: const EdgeInsets.symmetric(horizontal: 10),

          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              border: Border(
                top: BorderSide(color: Colors.grey.shade800),
              )
          ),
          child: Stack(
                children: [
                  //cover
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: song.coverUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (_, _) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade800,
                          child: const Icon(Icons.music_note, color: Colors.white,),
                        );
                      },
                      errorWidget: (_, _, _) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade800,
                          child: const Icon(Icons.music_note, color: Colors.white,),
                        );
                      },
                    ),
                  ),
              const SizedBox(width: 10,),

              //title + artist
              Expanded(
                child: Row(
                  children: [
                    // Title + Artist
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            song.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,

                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            song.artistName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Previous
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      onPressed: controller.playPrevious,
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      ),
                    ),

                    // Play / Pause
                    Obx(
                          () => IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        onPressed: () {
                          if (controller.isPLaying.value) {
                            controller.pause();
                          } else {
                            controller.resume();
                          }
                        },
                        icon: Icon(
                          controller.isPLaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Next
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      onPressed: controller.playNext,
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

}