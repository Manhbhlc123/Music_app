import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchHistorySection extends StatelessWidget
{
  final List<String> historyItems;
  final Function(String) onTapItem;
  final VoidCallback onClearAll;

  const SearchHistorySection({
    super.key,
    required this.historyItems,
    required this.onTapItem,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    if (historyItems.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton(onPressed: onClearAll, child: const Text('Clear All')),
            ],
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: historyItems.map((item) => ActionChip(
              label: Text(item),
              onPressed: () => onTapItem(item),
            )).toList(),
          ),
        ],
      ),
    );
  }
}