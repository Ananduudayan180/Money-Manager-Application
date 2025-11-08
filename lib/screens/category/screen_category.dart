import 'package:flutter/material.dart';
import 'package:money_manager/screens/category/category_list/expense_list.dart';
import 'package:money_manager/screens/category/category_list/income_list.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Income'),
              Tab(text: 'expense'),
            ],
          ),
          Expanded(child: TabBarView(children: [IncomeList(), ExpenseList()])),
        ],
      ),
    );
  }
}
