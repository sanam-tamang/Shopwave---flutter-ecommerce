import 'package:flutter/material.dart';

class CustomListTileCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;

  const CustomListTileCard({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          title: Text(title),
          trailing: Icon(icon ?? Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}
