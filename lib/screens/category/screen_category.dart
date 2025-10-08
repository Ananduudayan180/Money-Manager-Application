import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/screens/category/category_list/expense_list.dart';
import 'package:money_manager/screens/category/category_list/income_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  @override
  void initState() {
    super.initState();
    CategoryDb().refreshUI();
  }

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
