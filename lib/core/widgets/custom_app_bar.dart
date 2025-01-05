import 'package:flutter/material.dart';
import 'package:taski/resources/app_icons.dart';
import 'package:taski/resources/theme/palette/palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Pallette.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(AppIcons.check, width: 28, height: 28),
              const SizedBox(width: 8),
              Text('Taski', style: TextStyle(color: Pallette.gray600, fontSize: 20, fontWeight: FontWeight.w700)),
            ],
          ),
          Row(
            children: [
              Text('John', style: TextStyle(color: Pallette.gray600, fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(width: 14),
              Image.asset(AppIcons.avatar, width: 42, height: 42),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
