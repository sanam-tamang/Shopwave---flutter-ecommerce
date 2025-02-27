import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LayoutScaffold extends StatefulWidget {
  const LayoutScaffold({
    super.key,
    required this.shell,
  });
  final StatefulNavigationShell shell;
  @override
  State<LayoutScaffold> createState() => _LayoutScaffoldState();
}

class _LayoutScaffoldState extends State<LayoutScaffold> {
  final List<String> _iconPaths = [
    'assets/icons/home_outline.svg',
    'assets/icons/search.svg',
    'assets/icons/cart_outline.svg',
    'assets/icons/account_outline.svg',
  ];

  final List<String> _activeIconPaths = [
    'assets/icons/home_filled.svg',
    'assets/icons/search.svg',
    'assets/icons/cart_filled.svg',
    'assets/icons/account_filled.svg',
  ];

  final List<String> _labels = [
    'Home',
    'Search',
    'Cart',
    'Account',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.shell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorScheme.of(context).surfaceContainerLowest,
        currentIndex: widget.shell.currentIndex,
        onTap: widget.shell.goBranch,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        items: List.generate(4, (index) {
          return BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              _activeIconPaths[index],
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
            ),
            icon: SvgPicture.asset(
              _iconPaths[index],
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
            ),
            label: _labels[index],
          );
        }),
      ),
    );
  }
}
