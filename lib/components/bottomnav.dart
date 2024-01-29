import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 60.0,
      items: <Widget>[
        Image.asset(
          'assets/images/communitysupport/bottomNav/communitybtn.png',
          width: 30,
          height: 30,
        ),
        Image.asset(
          'assets/images/communitysupport/bottomNav/marketplacebtn.png',
          width: 30,
          height: 30,
        ),
        Image.asset(
          'assets/images/communitysupport/bottomNav/marketplacebtn.png',
          width: 30,
          height: 30,
        ),
      ],
      color: const Color(0xFFE0ECF8),
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: const Color(0xFF196DFF),
      animationDuration: const Duration(milliseconds: 300),
      onTap: onTap,
    );
  }
}
