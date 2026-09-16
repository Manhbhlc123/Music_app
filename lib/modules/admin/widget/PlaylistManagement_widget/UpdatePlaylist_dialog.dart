import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Playlist_model.dart';

class UpdatePlaylistDialog extends StatefulWidget {
  final PlaylistModel playlistModel;

  const UpdatePlaylistDialog({super.key, required this.playlistModel});

  @override
  State<UpdatePlaylistDialog> createState() => _UpdatePlaylistDialogState();
}

class _UpdatePlaylistDialogState extends State<UpdatePlaylistDialog> {
  late TextEditingController titleController;
  late TextEditingController coverController;

  bool? isPublic;

  @override
  void initState() {
    super.initState();

    final playlist = widget.playlistModel;

    titleController = TextEditingController(text: playlist.title);
    coverController = TextEditingController(text: playlist.coverUrl);
    isPublic = playlist.isPublic;
  }

  void updateAlbum() {
    final updatedPlaylist = widget.playlistModel.copyWith(
      title: titleController.text.trim(),
      coverUrl: coverController.text.trim(),
      isPublic: isPublic,
    );

    Get.back(result: updatedPlaylist);
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
      title: const Text("Update Playlist"),

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

              // PUBLIC TOGGLE
              SwitchListTile(
                title: const Text("Public Playlist"),
                value: isPublic ?? false,
                onChanged: (bool value) {
                  setState(() {
                    isPublic = value;
                  });
                },
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
