import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';

class UpdateArtistDialog extends StatefulWidget {
  final ArtistModel artistModel;

  const UpdateArtistDialog({super.key, required this.artistModel});

  @override
  State<UpdateArtistDialog> createState() => _UpdateArtistDialogState();
}

class _UpdateArtistDialogState extends State<UpdateArtistDialog> {
  late TextEditingController nameController;
  late TextEditingController imageController;
  late TextEditingController bioController;
  late TextEditingController countryController;

  bool? verified;

  @override
  void initState() {
    super.initState();

    final artist = widget.artistModel;

    nameController = TextEditingController(text: artist.name);
    imageController = TextEditingController(text: artist.avatarUrl);
    bioController = TextEditingController(text: artist.bio);
    countryController = TextEditingController(text: artist.country);

    verified = artist.verify;
  }

  void updateArtist() {
    final updatedArtist = widget.artistModel.copyWith(
      name: nameController.text.trim(),
      avatarUrl: imageController.text.trim(),
      bio: bioController.text.trim(),
      country: countryController.text.trim(),
      verify: verified,
    );

    Get.back(result: updatedArtist);
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
      title: const Text("Update Artist"),

      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // NAME
              TextField(
                controller: nameController,
                decoration: inputDecoration("Name"),
                maxLength: 200,
              ),

              const SizedBox(height: 12),

              // IMAGE
              TextField(
                controller: imageController,
                decoration: inputDecoration("Image URL"),
              ),

              const SizedBox(height: 12),

              // BIO
              TextField(
                controller: bioController,
                maxLines: 3,
                decoration: inputDecoration("Bio"),
              ),

              const SizedBox(height: 12),

              // COUNTRY
              TextField(
                controller: countryController,
                decoration: inputDecoration("Country"),
              ),

              const SizedBox(height: 12),

              // VERIFIED
              CheckboxListTile(
                title: const Text("Verified Artist"),
                value: verified ?? false,
                onChanged: (bool? value) {
                  setState(() => verified = value);
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

        ElevatedButton(onPressed: updateArtist, child: const Text("Update")),
      ],
    );
  }
}
