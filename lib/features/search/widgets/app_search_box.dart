import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppSearchBoxUI extends StatelessWidget {
  const AppSearchBoxUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: ColorScheme.of(context).surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(CupertinoIcons.search),
            Gap(16),
            Text(
              "Search",
            ),
          ],
        ),
      ),
    );
  }
}
