import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Download_model.dart';
import 'package:sq_mp3/modules/library/widgets/Download/Download_item.dart';

class DownloadSection extends StatelessWidget {
  final List<DownloadModel> downloads;

  const DownloadSection({super.key, required this.downloads});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: downloads.length,
      itemBuilder: (context, index) {
        return DownloadItem(download: downloads[index]);
      },
    );
  }
}
