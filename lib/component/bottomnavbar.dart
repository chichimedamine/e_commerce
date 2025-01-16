import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../helper/ColorsHelper.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({super.key, required this.currentindex, required this.fn});

  final int currentindex;
  final ValueChanged<int> fn;

  @override
  Widget build(BuildContext context) {
    return _buildBottomNav(currentindex, fn: fn);
  }
}

Widget _buildBottomNav(int currentIndex, {required ValueChanged<int> fn}) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      void onTap(int value) {
        fn;
        switch (value) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            break;
        }
      }

      return BottomNavigationBar(
        backgroundColor: ColorsHelper.gray200,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.squareStack),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.heart),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.user),
            label: 'Profile',
          ),
        ],
        onTap: onTap,
      );
    },
  );
}
