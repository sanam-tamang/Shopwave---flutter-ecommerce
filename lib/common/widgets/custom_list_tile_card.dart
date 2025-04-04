// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomListTileCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;

  const CustomListTileCard(
      {super.key,
      required this.title,
      this.icon,
      required this.onTap,
      this.bottomMargin = 0.0,
      padBottom});
  final double bottomMargin;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomMargin),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(title),
            trailing: Icon(icon ?? Icons.arrow_forward_ios, size: 16),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
