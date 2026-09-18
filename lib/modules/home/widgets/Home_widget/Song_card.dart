import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/core/services/Download_service.dart';
import 'package:sq_mp3/core/services/Token_service.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/data/provider/Download_api_provider.dart';
import 'package:sq_mp3/modules/favorite/controller/Favorite_controller.dart';
import 'package:sq_mp3/modules/home/controller/Home_controller.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/AlbumDialog.dart';
import 'package:sq_mp3/modules/home/widgets/Home_widget/PlaylistDialog.dart';
import 'package:sq_mp3/modules/library/controller/Download_controller.dart';
import 'package:sq_mp3/modules/library/controller/Library_controller.dart';
import 'package:sq_mp3/modules/player/controller/Player_controller.dart';

class SongCard extends StatelessWidget {
  final SongItemModel songModel;

  const SongCard({super.key, required this.songModel});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteController>();
    final libraryController = Get.find<LibraryController>();
    final downloadController = Get.find<DownloadController>();
    final tokenService = TokenService();
    final DownloadApiProvider downloadApiProvider = DownloadApiProvider();
    final DownloadService downloadService = DownloadService();
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              final playerController = Get.find<PlayerController>();

              final homeController = Get.find<HomeController>();
              homeController.addToRecentHistory(
                songModel.id.toString(),
                songModel.duration,
                "home_card",
              );

              playerController.playSong(songModel);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: songModel.coverUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            onLongPress: () {
              Get.bottomSheet(
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Wrap(
                    children: [
                      ListTile(
                        title: Text(
                          songModel.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(songModel.artistName),
                        trailing: const Icon(Icons.music_note),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.playlist_add),
                        title: const Text('Add to Playlist'),
                        onTap: () async {
                          Get.back();

                          await Future.delayed(
                            const Duration(milliseconds: 200),
                          );

                          await libraryController.loadPlaylistPage();

                          AddToPlaylistDialog.show(
                            songId: songModel.id.toString(),
                            playlists: libraryController.playlists.toList(),
                          );
                        },
                      ),

                      ListTile(
                        leading: const Icon(Icons.album),
                        title: const Text("Add to album"),
                        onTap: () async {
                          Get.back();

                          await libraryController.loadAlbumPage();

                          AddToAlbumDialog.show(
                            songId: songModel.id.toString(),
                            albums: libraryController.albums.toList(),
                          );
                        },
                      ),

                      Obx(() {
                        final isFavorite = favoriteController.isFavorite(
                          songModel.id,
                        );
                        return ListTile(
                          leading: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          title: Text(
                            isFavorite
                                ? 'Remove from Favorite'
                                : 'Add to Favorite',
                          ),
                          onTap: () async {
                            await favoriteController.toggleFavorite(songModel);
                            Get.back();
                          },
                        );
                      }),
                      ListTile(
                        leading: const Icon(Icons.share),
                        title: const Text('Share'),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.download),
                        title: const Text('Download'),
                        onTap: () async {
                          final token = await tokenService.getToken();
                          if (token != null) {
                            try {
                              final download = await downloadApiProvider
                                  .downloadSong(
                                    token: token,
                                    songId: songModel.id,
                                  );
                              downloadController.downloadSong(download);
                              Get.snackbar(
                                "Download",
                                "Starting download: ${songModel.title}",
                              );
                            } catch (e) {
                              Get.snackbar(
                                "Download Error",
                                "Failed to start download: ${e.toString()}",
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Authentication Required",
                              "Please login to download songs",
                            );
                          }
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Text(
            songModel.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            songModel.artistName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
