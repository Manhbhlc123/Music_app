import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class UpdateAlbumDialog extends StatefulWidget {
  final AlbumModel albumModel;

  const UpdateAlbumDialog({super.key, required this.albumModel});

  @override
  State<UpdateAlbumDialog> createState() => _UpdateAlbumDialogState();
}

class _UpdateAlbumDialogState extends State<UpdateAlbumDialog> {
  late TextEditingController titleController;
  late TextEditingController coverController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    final album = widget.albumModel;

    titleController = TextEditingController(text: album.title);
    coverController = TextEditingController(text: album.cover);
    descriptionController = TextEditingController(text: album.description);
  }

  void updateAlbum() {
    final updatedAlbum = widget.albumModel.copyWith(
      title: titleController.text.trim(),
      cover: coverController.text.trim(),
      description: descriptionController.text.trim(),
    );

    Get.back(result: updatedAlbum);
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Update Album"),

      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TITLE
              TextField(
                controller: titleController,
                decoration: inputDecoration("Title"),
                maxLength: 200,
              ),

              const SizedBox(height: 12),

              // COVER
              TextField(
                controller: coverController,
                decoration: inputDecoration("Cover URL"),
              ),

              const SizedBox(height: 12),

              // DESCRIPTION
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: inputDecoration("Description"),
              ),
            ],
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),

        ElevatedButton(onPressed: updateAlbum, child: const Text("Update")),
      ],
    );
  }
}
