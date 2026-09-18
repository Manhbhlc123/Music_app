import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/modules/home/controller/AlbumController.dart';

import 'package:sq_mp3/modules/home/controller/PlaylistController.dart';

class AddToAlbumDialog {
  static final albumController = Get.find<AlbumController>();

  static void show({
    required String songId,
    required List<AlbumModel> albums,
  }) {
    String? selectedAlbumId;
    print("OPEN ALBUM DIALOG");
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Thêm vào album',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        content: SizedBox(
          width: double.maxFinite,
          child: albums.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Text('Bạn chưa có album nào')),
                )
              : StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 400),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: albums.length,
                        itemBuilder: (context, index) {
                          final album= albums[index];

                          return RadioListTile<String>(
                            value: album.id,
                            groupValue: selectedAlbumId,

                            onChanged: (value) {
                              setState(() {
                                selectedAlbumId = value;
                              });
                            },

                            title: Text(
                              album.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            secondary: ClipRRect(
                              borderRadius: BorderRadius.circular(6),

                              child: Image.network(
                                album.cover,
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
              if (selectedAlbumId == null) {
                Get.snackbar(
                  'Thông báo',
                  'Vui lòng chọn một album',
                );
                return;
              }

              final success =
              await albumController.addSongToAlbum(
                selectedAlbumId!,
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
