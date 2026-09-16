import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/createRequest/AlbumCreate_request.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';

class CreateAlbumDialog extends StatefulWidget {
  const CreateAlbumDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAlbumDialogState();
}

class _CreateAlbumDialogState extends State<CreateAlbumDialog> {
  final AdminController adminController = Get.find<AdminController>();

  late TextEditingController titleController;
  late TextEditingController artistIdController;
  late TextEditingController coverUrlController;
  late TextEditingController releaseDateController;
  late TextEditingController descriptionController;


  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    artistIdController = TextEditingController();
    coverUrlController = TextEditingController();
    releaseDateController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    artistIdController.dispose();
    coverUrlController.dispose();
    releaseDateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String title) {
    return InputDecoration(label: Text(title), border: const OutlineInputBorder());
  }

  Future<void> selectReleaseDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      releaseDateController.text = picked.toIso8601String().split('T')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Album'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: inputDecoration('Title'),
            ),
            SizedBox(height: 12),
            Obx(
              () => DropdownMenu<String>(
                dropdownMenuEntries: adminController.artists
                    .map(
                      (artist) => DropdownMenuEntry<String>(
                        value: artist.id,
                        label: artist.name,
                      ),
                    )
                    .toList(),
                label: const Text('Select Artist'),
                onSelected: (String? value) {
                  if (value != null) {
                    artistIdController.text = value;
                  }
                },
                expandedInsets: EdgeInsets.zero,
                menuHeight: 250,
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.white60,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: coverUrlController,
              decoration: inputDecoration('Cover URL'),
            ),
            SizedBox(height: 12),
        TextField(
            controller: releaseDateController,
            readOnly: true,
            decoration: inputDecoration("Release Date").copyWith(
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_month),
                onPressed: selectReleaseDate,
              ),
            ),
          ),
            SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: inputDecoration('Description'),
              maxLines: 3,
            ),
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
                    if (titleController.text.isEmpty ||
                        artistIdController.text.isEmpty ||
                        releaseDateController.text.isEmpty) {
                      return;
                    }
                    final newAlbumData = AlbumCreateRequest(
                      title: titleController.text.trim(),
                      artistId: artistIdController.text.trim(),
                      coverUrl: coverUrlController.text.trim(),
                      releaseDate: DateTime.parse(releaseDateController.text.trim()),
                      description: descriptionController.text.trim(),
                    );

                    await adminController.createAlbum(newAlbumData);
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
