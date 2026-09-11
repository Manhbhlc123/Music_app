import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final int total;

  const LibraryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.total,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),

            SizedBox(height: 10),

            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),

            Text("$total", style: TextStyle(color: Colors.white12)),
          ],
        ),
      ),
    );
  }
}
