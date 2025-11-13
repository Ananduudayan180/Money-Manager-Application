import 'package:flutter/material.dart';
import 'package:money_manager/screens/category/category_list/expense_list.dart';
import 'package:money_manager/screens/category/category_list/income_list.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> gradient = [Color(0xFF3F51B5), Color(0xFF00BCD4)];
    Color singleTheme = Color(0xFF006FAD);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: gradient)),
        ),
        title: Text(
          "CATEGORY",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.9),
            // fontFamily: 'Montserrat',
          ),
        ),
        // centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              dividerColor: Colors.transparent,
              labelStyle: TextStyle(fontWeight: FontWeight.w400),
              unselectedLabelColor: Colors.black,
              labelColor: singleTheme,
              indicatorColor: singleTheme,
              tabs: [
                Tab(text: 'Income'),
                Tab(text: 'Expense'),
              ],
            ),
            Expanded(
              child: TabBarView(children: [IncomeList(), ExpenseList()]),
            ),
          ],
        ),
      ),
    );
  }
}
