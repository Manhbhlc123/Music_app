import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sq_mp3/data/model/Playlist_model.dart';
import 'package:sq_mp3/modules/home/controller/PlaylistController.dart';

class AddToPlaylistDialog {
  static final playlistController = Get.find<PlaylistController>();

  static void show({
    required String songId,
    required List<PlaylistModel> playlists,
  }) {
    String? selectedPlaylistId;
    print("===== OPEN PLAYLIST DIALOG =====");
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Thêm vào playlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        content: SizedBox(
          width: double.maxFinite,
          child: playlists.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Text('Bạn chưa có playlist nào')),
                )
              : StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 400),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: playlists.length,
                        itemBuilder: (context, index) {
                          final playlist = playlists[index];

                          return RadioListTile<String>(
                            value: playlist.id,
                            groupValue: selectedPlaylistId,

                            onChanged: (value) {
                              setState(() {
                                selectedPlaylistId = value;
                              });
                            },

                            title: Text(
                              playlist.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            secondary: ClipRRect(
                              borderRadius: BorderRadius.circular(6),

                              child: Image.network(
                                playlist.coverUrl,
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,

                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 45,
                                    height: 45,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.music_note),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),

        actions: [
          // HỦY
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Hủy'),
          ),

          // THÊM
          ElevatedButton(
            onPressed: () async {
              if (selectedPlaylistId == null) {
                Get.snackbar(
                  'Thông báo',
                  'Vui lòng chọn một playlist',
                );
                return;
              }

              final success =
              await playlistController.addSongToPlaylist(
                selectedPlaylistId!,
                songId,
              );

              if (success) {
                if (Get.isDialogOpen == true) {
                  Navigator.of(Get.overlayContext!).pop();
                }
              }
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
