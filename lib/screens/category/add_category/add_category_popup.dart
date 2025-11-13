import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

ValueNotifier<CategoryType> radioSelectedValue = ValueNotifier(
  CategoryType.income,
);
final textController = TextEditingController();
int values = 0;
const Color themeColor = Color(0xFF546E7A);
void addCategory(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
        title: const Text(
          'ADD CATEGORY',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        content: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: 'Category type',
            suffixIcon: const Icon(
              PhosphorIconsRegular.squaresFour,
              color: themeColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: themeColor),
              borderRadius: BorderRadius.circular(8),
            ),
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
                  child: const Column(
                    children: [
                      RadioListTile<CategoryType>(
                        activeColor: themeColor,
                        value: CategoryType.income,
                        title: Text('Income'),
                      ),
                      RadioListTile<CategoryType>(
                        activeColor: themeColor,
                        value: CategoryType.expense,
                        title: Text('Expence'),
                      ),
                    ],
                  ),
                ),
          ),

          ElevatedButton(
            onPressed: () {
              if (textController.text.isEmpty) {
                return;
              }
              final category = CategoryModel(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                name: textController.text,
                type: radioSelectedValue.value,
              );
              CategoryDb().insertCategory(category);
              textController.clear();
              Navigator.of(ctx).pop();
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Icon(PhosphorIconsRegular.plusSquare, color: Colors.white),
          ),
        ],
      );
    },
  );
}
