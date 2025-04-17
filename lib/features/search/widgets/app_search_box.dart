import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/routes.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AppSearchBoxUI extends StatelessWidget {
  const AppSearchBoxUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(AppRouteName.search),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: ColorScheme.of(context).surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorScheme.of(context).primary,
              )),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.search,
                color: ColorScheme.of(context).primary,
              ),
              Gap(16),
              Text(
                "Search",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
