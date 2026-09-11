import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controller/Player_controller.dart';

class PlayerContent extends GetView<PlayerController> {
  const PlayerContent({super.key});

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        final song = controller.currentSong.value;

        if (song == null) {
          return const Center(
            child: Text(
              "Chưa có bài hát",
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        return Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 24),

          child: Column(
            children: [
              const Spacer(),

              //cover
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: song.coverUrl,
                  width: double.infinity,
                  height: 330,
                  fit: BoxFit.cover,
                  placeholder: (_, _) {
                    return Container(
                      width: double.infinity,
                      height: 330,
                      color: Colors.grey.shade900,
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: 80,
                      ),
                    );
                  },
                  errorWidget: (_, _, _) {
                    return Container(
                      width: double.infinity,
                      height: 330,
                      color: Colors.grey.shade900,
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: 80,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              //title
              Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              //artist
              Text(
                song.artistName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 24),
              ),

              const SizedBox(height: 25),

              //thanh xử lý chạy time
              StreamBuilder<Duration>(
                stream: controller.player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration = controller.player.duration ?? Duration.zero;

                  double sliderValue = 0;

                  if (duration.inMilliseconds > 0) {
                    sliderValue = position.inMilliseconds / duration.inMilliseconds;
                  }

                  return Column(
                    children: [
                      Slider(
                        value: sliderValue.clamp(0.0, 1.0),
                        onChanged: (value) {
                          sliderValue = value;
                        },
                        onChangeEnd: (value)
                        {
                          final newposition = duration * value;
                          controller.seek(newposition);
                        },

                        activeColor: Colors.green,
                        inactiveColor: Colors.grey.shade700,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDuration(position),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),

                            Text(
                              formatDuration(duration),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              //control
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //shuffle
                  Obx(() {
                    return IconButton(
                      onPressed: controller.toggleShuffle,
                      icon: Icon(
                        Icons.shuffle,
                        color: controller.isShuffle.value
                            ? Colors.green
                            : Colors.white,
                      ),
                    );
                  }),

                  //previous
                  IconButton(
                    onPressed: controller.playPrevious,
                    icon: Icon(Icons.skip_previous, color: Colors.white),
                  ),

                  // PLAY / PAUSE
                  Obx(() {
                    return Container(
                      width: 65,
                      height: 65,

                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),

                      child: IconButton(
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

                          color: Colors.black,

                          size: 35,
                        ),
                      ),
                    );
                  }),

                  // NEXT
                  IconButton(
                    iconSize: 40,

                    onPressed: controller.playNext,

                    icon: const Icon(Icons.skip_next, color: Colors.white),
                  ),

                  // REPEAT
                  Obx(() {
                    final mode = controller.repeatMode.value;

                    return IconButton(
                      onPressed: controller.toggleRepeat,

                      icon: Icon(
                        mode == RepeatMode.one
                            ? Icons.repeat_one
                            : Icons.repeat,

                        color: mode == RepeatMode.none
                            ? Colors.white
                            : Colors.green,
                      ),
                    );
                  }),
                ],
              ),
              const Spacer(),
            ],
          ),
        );
      }),
    );
  }
}