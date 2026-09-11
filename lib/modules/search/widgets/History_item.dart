import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/search_history_model.dart';

class HistoryItem extends StatelessWidget {
  final SearchHistoryModel model;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const HistoryItem({
    super.key,
    required this.model,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.history, color: Colors.grey),

      title: Text(model.keyword, style: const TextStyle(color: Colors.white)),
      subtitle: Text(model.resultType!, style: const TextStyle(color: Colors.grey),
      ),

      trailing: IconButton(
        icon: const Icon(Icons.close, color: Colors.grey),
        onPressed: onDelete,
      ),
    );
  }
}
