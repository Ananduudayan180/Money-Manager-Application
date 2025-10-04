import 'package:flutter/material.dart';
import 'package:money_manager/screens/home/screen_home.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.bottomNavigationIndex,
      builder: (BuildContext context, int newIndex, child) {
        return BottomNavigationBar(
          currentIndex: ScreenHome.bottomNavigationIndex.value,
          onTap: (index) {
            ScreenHome.bottomNavigationIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
          ],
        );
      },
    );
  }
}
