import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryListNotifier,
      builder: (BuildContext context, List<CategoryModel> category, child) {
        return ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(category[index].name),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return Divider();
          },
          itemCount: category.length,
        );
      },
    );
  }
}
