import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sq_mp3/data/model/Trending_keyword_model.dart';

class TrendingKeywordSection extends StatelessWidget {
  final List<TrendingKeywordModel> items;
  final Function(String) onTapItem;

  const TrendingKeywordSection({
    super.key,
    required this.items,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: AlignmentGeometry.centerLeft,
          child: Text(
            "Xu hướng tìm kiếm",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, _) =>
              const Divider(color: Colors.white10, height: 1),
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              leading: const Icon(
                Icons.local_fire_department,
                color: Colors.orange,
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                item.keyword ?? "",
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              trailing: const Icon(
                Icons.trending_up,
                color: Colors.white38,
                size: 20,
              ),
              onTap: () => onTapItem(item.keyword ?? ""),
            );
          },
        ),
      ],
    );
  }
}
