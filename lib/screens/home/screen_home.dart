import 'package:flutter/material.dart';
import 'package:money_manager/screens/category/add_category/add_category_popup.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/home/widgets/bottom_navigation_bar.dart';
import 'package:money_manager/screens/transactions/screen_transactions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final pages = [ScreenTransactions(), ScreenCategory()];
  static ValueNotifier<int> bottomNavigationIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    List<Color> gradient = [Color(0xFF3F51B5), Color(0xFF00BCD4)];
    return Scaffold(
      floatingActionButton: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(colors: gradient).createShader(bounds);
        },
        child: FloatingActionButton(
          onPressed: () {
            if (bottomNavigationIndex.value == 0) {
              //  add transaction
              Navigator.of(context).pushNamed('AddTransactionsScreen');
            } else {
              // add category
              addCategory(context);
            }
          },
          backgroundColor: Colors.white,
          elevation: 2,
          child: Icon(PhosphorIconsRegular.plus, color: Colors.black),
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(),
      body: ValueListenableBuilder(
        valueListenable: bottomNavigationIndex,
        builder: (BuildContext context, int pageIndex, child) {
          return pages[pageIndex];
        },
      ),
    );
  }
}
