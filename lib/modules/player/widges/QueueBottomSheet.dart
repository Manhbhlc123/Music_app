import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/player/controller/Queue_controller.dart';

class QueueBottomSheet extends GetView<QueueController> {
  const QueueBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Danh sách chờ",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: controller.clearQueue,
                child: const Text("xóa tất cả"),
              ),
            ],
          ),

          const Divider(),

          Expanded(
            child: Obx(() {
              if (controller.queue.isEmpty) {
                return const Center(child: Text("Danh sách chờ trống"));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final song = controller.queue[index];

                  final isPlaying = index == controller.currentIndex.value;

                  return ListTile(
                    title: Text(
                      song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        song.coverUrl,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),

                    subtitle: Text(song.artistName),

                    trailing: isPlaying
                        ? const Icon(Icons.equalizer)
                        : IconButton(
                            onPressed: () => controller.removeFromQueue(index),
                            icon: Icon(Icons.close),
                          ),
                    onTap: () {},
                  );
                },
                itemCount: controller.queue.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}
