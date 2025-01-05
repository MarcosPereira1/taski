import 'package:flutter/material.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Pallette.white,
      selectedItemColor: Pallette.blue500,
      unselectedItemColor: Pallette.gray400,
      selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.view_list), label: 'Todo'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Create'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Done'),
      ],
    );
  }
}
