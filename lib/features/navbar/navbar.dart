import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _currentIndex = 0;

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

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eCommerce App'),
      ),
      body: Center(
        child: Text('Selected: ${_labels[_currentIndex]}'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorScheme.of(context).surfaceContainerLowest,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
