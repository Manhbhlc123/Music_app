import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/createRequest/SongCreate_request.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/provider/Song_api_provider.dart';
import 'package:sq_mp3/modules/admin/controller/Admin_controller.dart';

class CreateSongDialog extends StatefulWidget {
  const CreateSongDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CreateSongDialogState();
}

class _CreateSongDialogState extends State<CreateSongDialog> {
  final AdminController adminController = Get.find<AdminController>();

  late TextEditingController titleController;
  late TextEditingController artistIdController;
  late TextEditingController albumIdController;
  late TextEditingController genreIdController;
  late TextEditingController durationController;
  late TextEditingController audioUrlNormalController;
  late TextEditingController audioUrlHqController;
  late TextEditingController coverUrlController;
  late TextEditingController lyricsPlainController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    artistIdController = TextEditingController();
    albumIdController = TextEditingController();
    genreIdController = TextEditingController();
    durationController = TextEditingController();
    audioUrlNormalController = TextEditingController();
    audioUrlHqController = TextEditingController();
    coverUrlController = TextEditingController();
    lyricsPlainController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    artistIdController.dispose();
    albumIdController.dispose();
    genreIdController.dispose();
    durationController.dispose();
    audioUrlNormalController.dispose();
    audioUrlHqController.dispose();
    coverUrlController.dispose();
    lyricsPlainController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String title) {
    return InputDecoration(label: Text(title), border: const OutlineInputBorder());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Song'),
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
            Obx(
              () => DropdownMenu<String>(
                dropdownMenuEntries: adminController.albums
                    .map(
                      (album) => DropdownMenuEntry<String>(
                        value: album.id,
                        label: album.title,
                      ),
                    )
                    .toList(),
                label: const Text('Select Album'),
                onSelected: (String? value) {
                  if (value != null) {
                    albumIdController.text = value;
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
            Obx(
              () => DropdownMenu<String>(
                dropdownMenuEntries: adminController.genres
                    .map(
                      (genre) => DropdownMenuEntry<String>(
                        value: genre.id,
                        label: genre.name,
                      ),
                    )
                    .toList(),
                label: const Text('Select Genre'),
                onSelected: (String? value) {
                  if (value != null) {
                    genreIdController.text = value;
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
              controller: durationController,
              decoration: inputDecoration('Duration (seconds)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: audioUrlNormalController,
              decoration: inputDecoration('Audio URL (Normal)'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: audioUrlHqController,
              decoration: inputDecoration('Audio URL (HQ)'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: coverUrlController,
              decoration: inputDecoration('Cover URL'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: lyricsPlainController,
              decoration: inputDecoration('Lyrics'),
              maxLines: 3,
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
                    final newSongData = SongCreateRequest(
                      title: titleController.text.trim(),
                      artistId: artistIdController.text.trim(),
                      albumId: albumIdController.text.trim(),
                      genreId: genreIdController.text.trim(),
                      duration:
                          int.tryParse(durationController.text.trim()) ?? 0,
                      audioUrlNormal: audioUrlNormalController.text.trim(),
                      audioUrlHq: audioUrlHqController.text.trim(),
                      coverUrl: coverUrlController.text.trim(),
                      lyricsPlain: lyricsPlainController.text.trim(),
                    );

                    await adminController.createSong(newSongData);
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
