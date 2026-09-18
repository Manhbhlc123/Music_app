
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/home/controller/AlbumController.dart';
import 'package:sq_mp3/modules/home/controller/PlaylistController.dart';

class AddSongToAlbumDialog {
  final String albumId;
  static final albumController = Get.find<AlbumController>();

  const AddSongToAlbumDialog({required this.albumId});

  static void show({
    required String albumId,
    required List<SongItemModel> songs,
  }) {
    String? selectSongId;
    print("OPEN SONG DIALOG");
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Thêm vào album',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        content: SizedBox(
          width: double.maxFinite,
          child: songs.isEmpty
              ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: Text('Bạn chưa có song nào')),
          )
              : StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];

                    return RadioListTile<String>(
                      value: song.id,
                      groupValue: selectSongId,

                      onChanged: (value) {
                        setState(() {
                          selectSongId = value;
                        });
                      },

                      title: Text(
                        song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      secondary: ClipRRect(
                        borderRadius: BorderRadius.circular(6),

                        child: Image.network(
                          song.coverUrl,
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
              if (selectSongId == null) {
                Get.snackbar(
                  'Thông báo',
                  'Vui lòng chọn một song',
                );
                return;
              }

              final success =
              await albumController.addSongToAlbum(
                albumId,
                selectSongId!
              );

              if (success) {
                Get.snackbar(
                  'Thành công',
                  'Đã thêm bài hát vào album',
                );
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