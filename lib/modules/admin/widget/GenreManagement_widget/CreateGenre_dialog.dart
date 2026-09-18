import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/createRequest/AlbumCreate_request.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/createRequest/ArtistCreate_request.dart';
import 'package:sq_mp3/data/createRequest/GenreCreate_request.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';

class CreateGenreDialog extends StatefulWidget {
  const CreateGenreDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CreateGenreDialogState();
}

class _CreateGenreDialogState extends State<CreateGenreDialog> {
  final AdminController adminController = Get.find<AdminController>();

  late TextEditingController nameController;
  late TextEditingController coverUrlController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    coverUrlController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    coverUrlController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String title) {
    return InputDecoration(
      label: Text(title),
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Genre'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: inputDecoration('Name'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: coverUrlController,
              decoration: inputDecoration('cover Url'),
              maxLines: 3,
            ),
            SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: inputDecoration('description'),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        Obx(
          () => ElevatedButton(
            onPressed: adminController.isLoading.value
                ? null
                : () async {
                    if (nameController.text.isEmpty) {
                      return;
                    }
                    final newGenreData = GenreCreateRequest(
                      name: nameController.text.trim(),
                      coverUrl: coverUrlController.text.trim(),
                      description: descriptionController.text.trim(),
                    );

                    await adminController.createGenre(newGenreData);
                    if (context.mounted) Navigator.pop(context);
                  },
            child: adminController.isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Create'),
          ),
        ),
      ],
    );
  }
}
