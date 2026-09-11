import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              children: [
                const SizedBox(width: 16),

                const Text(
                  "Thư Viện",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),

                const Spacer(),

                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.getRemainingDownload();
                              Get.toNamed(Routes.download);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.download,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                  SizedBox(height: 8),
                                  Text("Tải Xuống"),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.playerView);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.playlist_play,
                                    color: Colors.orange,
                                    size: 40,
                                  ),
                                  SizedBox(height: 8),
                                  Text("Danh sách phát"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.loadFollowedArtistPage();
                              Get.toNamed(Routes.followedArtist);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.purple,
                                    size: 40,
                                  ),
                                  SizedBox(height: 8),
                                  Text("Nghệ sĩ đã follow"),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.loadAlbumPage();
                              Get.toNamed(Routes.album);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.album,
                                    color: Colors.teal,
                                    size: 40,
                                  ),
                                  SizedBox(height: 8),
                                  Text("Album"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.loadPlaylistPage();
                              Get.toNamed(Routes.playlistLibrary);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.playlist_play,
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Playlist của tôi",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
