import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/model/Song_item_model.dart';

class UpdateSongDialog extends StatefulWidget {
  final SongItemModel song;

  const UpdateSongDialog({super.key, required this.song});

  @override
  State<UpdateSongDialog> createState() => _UpdateSongDialogState();
}

class _UpdateSongDialogState extends State<UpdateSongDialog> {
  late TextEditingController titleController;
  late TextEditingController durationController;
  late TextEditingController audioUrlNormalController;
  late TextEditingController audioUrlHqController;
  late TextEditingController coverUrlController;
  late TextEditingController lyricsController;
  // late TextEditingController releaseDateController;
  // late TextEditingController searchKeywordsController;

  String? artistId;
  String? albumId;
  String? genreId;

  bool isActive = true;

  @override
  void initState() {
    super.initState();

    final song = widget.song;

    titleController = TextEditingController(text: song.title);

    durationController = TextEditingController(text: song.duration.toString());

    audioUrlNormalController = TextEditingController(
      text: song.audioUrlNormal ?? '',
    );

    audioUrlHqController = TextEditingController(text: song.audioUrlHq ?? '');

    coverUrlController = TextEditingController(text: song.coverUrl ?? '');

    lyricsController = TextEditingController(text: song.lyricsPlain ?? '');

    artistId = song.artistId;
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    titleController.dispose();
    durationController.dispose();
    audioUrlNormalController.dispose();
    audioUrlHqController.dispose();
    coverUrlController.dispose();
    lyricsController.dispose();
    // releaseDateController.dispose();
    // searchKeywordsController.dispose();

    super.dispose();
  }

  Future<void> selectReleaseDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    // if (picked != null) {
    //   setState(() {
    //     releaseDateController.text = _formatDate(picked);
    //   });
    // }
  }

  void updateSong() {
    final duration = int.tryParse(durationController.text.trim());

    DateTime? releaseDate;

    // if (releaseDateController.text.trim().isNotEmpty) {
    //   releaseDate = DateTime.tryParse(releaseDateController.text.trim());
    // }

    if (duration == null && durationController.text.trim().isNotEmpty) {
      Get.snackbar("Error", "Duration must be a number");
      return;
    }

    // if (releaseDateController.text.trim().isNotEmpty && releaseDate == null) {
    //   Get.snackbar("Error", "Release date must have format YYYY-MM-DD");
    //   return;
    // }

    final updatedSong = widget.song.copyWith(
      title: titleController.text.trim(),

      artistId: artistId,

      duration: duration,

      audioUrlNormal: audioUrlNormalController.text.trim(),
      audioUrlHq: audioUrlHqController.text.trim(),
      coverUrl: coverUrlController.text.trim(),

      lyricsPlain: lyricsController.text,
    );

    Get.back(result: updatedSong);
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
      title: const Text("Update Song"),

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

              // ARTIST ID
              TextField(
                controller: TextEditingController(text: artistId ?? ''),
                decoration: inputDecoration("Artist ID"),
                onChanged: (value) {
                  artistId = value.trim().isEmpty ? null : value.trim();
                },
              ),

              const SizedBox(height: 12),

              // ALBUM ID
              TextField(
                controller: TextEditingController(text: albumId ?? ''),
                decoration: inputDecoration("Album ID"),
                onChanged: (value) {
                  albumId = value.trim().isEmpty ? null : value.trim();
                },
              ),

              const SizedBox(height: 12),

              // GENRE ID
              TextField(
                controller: TextEditingController(text: genreId ?? ''),
                decoration: inputDecoration("Genre ID"),
                onChanged: (value) {
                  genreId = value.trim().isEmpty ? null : value.trim();
                },
              ),

              const SizedBox(height: 12),

              // DURATION
              TextField(
                controller: durationController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration("Duration (seconds)"),
              ),

              const SizedBox(height: 12),

              // NORMAL AUDIO
              TextField(
                controller: audioUrlNormalController,
                decoration: inputDecoration("Audio URL Normal"),
              ),

              const SizedBox(height: 12),

              // HQ AUDIO
              TextField(
                controller: audioUrlHqController,
                decoration: inputDecoration("Audio URL HQ"),
              ),

              const SizedBox(height: 12),

              // COVER
              TextField(
                controller: coverUrlController,
                decoration: inputDecoration("Cover URL"),
              ),

              const SizedBox(height: 12),

              // RELEASE DATE
              // TextField(
              //   controller: releaseDateController,
              //   readOnly: true,
              //   decoration: inputDecoration("Release Date").copyWith(
              //     suffixIcon: IconButton(
              //       icon: const Icon(Icons.calendar_month),
              //       onPressed: selectReleaseDate,
              //     ),
              //   ),
              // ),

              const SizedBox(height: 12),

              // SEARCH KEYWORDS
              // TextField(
              //   controller: searchKeywordsController,
              //   decoration: inputDecoration("Search Keywords"),
              // ),

              const SizedBox(height: 12),

              // LYRICS
              TextField(
                controller: lyricsController,
                maxLines: 8,
                decoration: inputDecoration("Lyrics"),
              ),

              const SizedBox(height: 12),

              // ACTIVE
              SwitchListTile(
                title: const Text("Active"),
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = value;
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

        ElevatedButton(onPressed: updateSong, child: const Text("Update")),
      ],
    );
  }
}
