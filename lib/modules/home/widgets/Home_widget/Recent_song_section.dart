import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/model/Recent_song_model.dart';
import 'package:sq_mp3/modules/home/controller/Home_controller.dart';

class RecentSongSection extends GetView<HomeController> {
  final List<RecentSongModel> songs;

  const RecentSongSection({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (_, index) {
        final song = songs[index];
        return ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: song.coverUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  const Icon(Icons.music_note),
            ),
          ),
          title: Text(song.songTitle),
          subtitle: Text(song.artistName),
          trailing: IconButton(
            onPressed: () async {
              Get.dialog(
                AlertDialog(
                  title: const Text("Xóa lịch sử"),
                  content: const Text("Bạn có chắc chắn muốn xóa bài hát này khỏi danh sách gần đây?"),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Hủy"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Get.back();
                        await controller.deleteSongInHistory(song.id);
                        Get.snackbar("Thông báo", "Đã xóa bài hát khỏi lịch sử");
                      },
                      child: const Text("Xóa", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        );
      },
    );
  }
}
