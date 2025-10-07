import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';

ValueNotifier<CategoryType> radioSelectedValue = ValueNotifier(
  CategoryType.income,
);
final textController = TextEditingController();
int values = 0;
void addCategory(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('Add category'),
        content: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Category type',
          ),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: radioSelectedValue,
            builder: (BuildContext context, CategoryType newvalue, child) =>
                RadioGroup(
                  groupValue: radioSelectedValue.value,
                  onChanged: (value) {
                    if (value != null) {
                      radioSelectedValue.value = value;
                    } else {
                      return;
                    }
                  },
                  child: Column(
                    children: [
                      RadioListTile<CategoryType>(
                        value: CategoryType.income,
                        title: Text('Income'),
                      ),
                      RadioListTile<CategoryType>(
                        value: CategoryType.expense,
                        title: Text('Expence'),
                      ),
                    ],
                  ),
                ),
          ),

          ElevatedButton(
            onPressed: () {
              final category = CategoryModel(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                name: textController.text,
                type: radioSelectedValue.value,
              );
              CategoryDb().insertCategory(category);
              textController.clear();
              Navigator.of(ctx).pop();
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}
