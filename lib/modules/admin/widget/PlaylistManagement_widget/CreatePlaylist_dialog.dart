import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/createRequest/PlaylistCreate_request.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';

class CreatePlaylistDialog extends StatefulWidget {
  const CreatePlaylistDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CreatePlaylistDialogState();
}

class _CreatePlaylistDialogState extends State<CreatePlaylistDialog> {
  final AdminController adminController = Get.find<AdminController>();

  late TextEditingController titleController;
  late TextEditingController coverUrlController;

  bool? isPublic;
  bool? isSystem;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    coverUrlController = TextEditingController();
    isPublic = false;
    isSystem = false;
  }

  @override
  void dispose() {
    titleController.dispose();
    coverUrlController.dispose();
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

            TextField(
              controller: coverUrlController,
              decoration: inputDecoration('coverUrl'),
            ),

            SizedBox(height: 12),

            SwitchListTile(
              value: isPublic ?? false,
              onChanged: (bool value) => setState(() {
                isPublic = value;
              }),
              title: Text("isPublic"),
            ),

            SizedBox(height: 12),

            SwitchListTile(
              value: isSystem ?? false,
              onChanged: (bool value) => setState(() {
                isSystem = value;
              }),
              title: Text("isSystem"),
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
                    if (titleController.text.isEmpty) {
                      return;
                    }
                    final newPlaylist = PlaylistCreateRequest(
                      title: titleController.text.trim(),
                      coverUrl: coverUrlController.text.trim(),
                      isPublic: isPublic ?? false,
                      isSystem: isSystem ?? false,
                    );
                    await adminController.createPlaylist(newPlaylist);
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
