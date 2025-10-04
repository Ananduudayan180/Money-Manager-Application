import 'package:flutter/material.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/home/widgets/bottom_navigation_bar.dart';
import 'package:money_manager/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final pages = [ScreenTransactions(), ScreenCategory()];
  static ValueNotifier<int> bottomNavigationIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'MONEY MANAGER',
          style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, color: Colors.white),
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
