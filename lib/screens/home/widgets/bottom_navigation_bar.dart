import 'package:flutter/material.dart';
import 'package:money_manager/screens/home/screen_home.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> gradient = [Color(0xFF3F51B5), Color(0xFF00BCD4)];
    return ValueListenableBuilder(
      valueListenable: ScreenHome.bottomNavigationIndex,
      builder: (BuildContext context, int newIndex, child) {
        return BottomNavigationBar(
          selectedItemColor: Colors.black,
          currentIndex: ScreenHome.bottomNavigationIndex.value,
          // selectedItemColor:GradientIcon(icon: icon, gradient: gradient)
          onTap: (index) {
            ScreenHome.bottomNavigationIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                PhosphorIconsRegular.arrowsLeftRight,
                color: Colors.black26,
              ),
              label: 'Transactions',
              activeIcon: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(colors: gradient).createShader(bounds);
                },
                child: Icon(
                  PhosphorIconsRegular.arrowsLeftRight,
                  color: Colors.white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                PhosphorIconsRegular.squaresFour,
                color: Colors.black26,
              ),
              label: 'Category',
              activeIcon: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(colors: gradient).createShader(bounds);
                },
                child: Icon(
                  PhosphorIconsRegular.squaresFour,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
