import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/genre_model.dart';

class UpdateGenreDialog extends StatefulWidget {
  final GenresModel genresModel;

  const UpdateGenreDialog({super.key, required this.genresModel});

  @override
  State<UpdateGenreDialog> createState() => _UpdateGenreDialogState();
}

class _UpdateGenreDialogState extends State<UpdateGenreDialog> {
  late TextEditingController nameController;
  late TextEditingController coverUrlController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    final genre = widget.genresModel;

    nameController = TextEditingController(text: genre.name);
    coverUrlController = TextEditingController(text: genre.coverUrl);
    descriptionController = TextEditingController(text: genre.description);
  }

  void updateGenre() {
    final updatedGenre = widget.genresModel.copyWith(
      name: nameController.text.trim(),
      coverUrl: coverUrlController.text.trim(),
      description: descriptionController.text.trim(),
    );

    Get.back(result: updatedGenre);
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
      title: const Text("Update Genres"),

      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // name
              TextField(
                controller: nameController,
                decoration: inputDecoration("Name"),
                maxLength: 200,
              ),

              const SizedBox(height: 12),

              // cover url
              TextField(
                controller: coverUrlController,
                decoration: inputDecoration("cover Url"),
              ),

              const SizedBox(height: 12),

              // description
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: inputDecoration("description"),
              ),

              const SizedBox(height: 12),
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

        ElevatedButton(onPressed: updateGenre, child: const Text("Update")),
      ],
    );
  }
}
