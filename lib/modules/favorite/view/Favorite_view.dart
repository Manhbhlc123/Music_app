import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/favorite/controller/Favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              children: [
                const SizedBox(width: 16),

                const Text(
                  'Bài hát yêu thích',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),

                const SizedBox(width: 8),
              ],
            ),
          ),

          // Danh sách bài hát
          Expanded(
            child: Obx(() {
              if (controller.loading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.favoriteSongs.isEmpty) {
                return const Center(
                  child: Text('Chưa có bài hát yêu thích'),
                );
              }

              return ListView.builder(
                itemCount: controller.favoriteSongs.length,
                itemBuilder: (context, index) {
                  final item = controller.favoriteSongs[index];

                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        item.coverUrl ?? '',
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                        errorBuilder: (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return Container(
                            width: 55,
                            height: 55,
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.music_note,
                            ),
                          );
                        },
                      ),
                    ),

                    title: Text(
                      item.title ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: Text(
                      item.artistName ?? 'Unknown Artist',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),

                    onTap: () {
                      // TODO: phát bài hát
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}