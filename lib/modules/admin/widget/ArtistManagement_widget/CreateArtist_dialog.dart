import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/createRequest/AlbumCreate_request.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/createRequest/ArtistCreate_request.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';

class CreateArtistDialog extends StatefulWidget {
  const CreateArtistDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CreateArtistDialogState();
}

class _CreateArtistDialogState extends State<CreateArtistDialog> {
  final AdminController adminController = Get.find<AdminController>();

  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController avatarUrlController;
  late TextEditingController countryController;

  List<SongItemModel> topSongs = [];
  List<AlbumModel> albums = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    bioController = TextEditingController();
    avatarUrlController = TextEditingController();
    countryController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    avatarUrlController.dispose();
    countryController.dispose();
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
      title: const Text('Create New Artist'),
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
              controller: bioController,
              decoration: inputDecoration('Bio'),
              maxLines: 3,
            ),
            SizedBox(height: 12),
            TextField(
              controller: avatarUrlController,
              decoration: inputDecoration('Avatar URL'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: countryController,
              decoration: inputDecoration('Country'),
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
                    if (nameController.text.isEmpty) {
                      return;
                    }
                    final newArtistData = ArtistCreateRequest(
                      name: nameController.text.trim(),
                      bio: bioController.text.trim(),
                      avatarUrl: avatarUrlController.text.trim(),
                      country: countryController.text.trim(),
                      topSongs: topSongs.map((e) => e).toList(),
                      albums: albums.map((e) => e).toList(),
                    );

                    await adminController.createArtist(newArtistData);
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
