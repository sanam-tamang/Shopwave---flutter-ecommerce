import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _currentIndex = 0;

  // List of SVG icons (eCommerce-related)
  final List<String> _iconPaths = [
    'assets/icons/home.svg', 
    'assets/icons/search.svg', 
    'assets/icons/cart.svg', 
    'assets/icons/account.svg', 
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
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: List.generate(4, (index) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _iconPaths[index],
              width: 24,
              height: 24,
            ),
            label: _labels[index],
          );
        }),
      ),
    );
  }
}
