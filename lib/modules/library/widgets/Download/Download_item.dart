import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Download_model.dart';

class DownloadItem extends StatelessWidget {
  final DownloadModel download;

  const DownloadItem({super.key, required this.download});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(download.songTitle),
      subtitle: Text(download.downloadedAt.toIso8601String()),
      leading: Icon(Icons.music_note),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
    );
  }
}
