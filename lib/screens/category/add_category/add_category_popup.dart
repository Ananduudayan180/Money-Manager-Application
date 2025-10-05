import 'package:flutter/material.dart';

ValueNotifier<int> radioSelectedValue = ValueNotifier(0);

int values = 0;
void addCategory(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text('Add category'),
        content: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Category type',
          ),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: radioSelectedValue,
            builder: (BuildContext context, int newvalue, child) => RadioGroup(
              groupValue: radioSelectedValue.value,
              onChanged: (value) {
                if (value != null) {
                  radioSelectedValue.value = value;
                }
              },
              child: Column(
                children: [
                  RadioListTile<int>(value: 0, title: Text('Income')),
                  RadioListTile<int>(value: 1, title: Text('Expence')),
                ],
              ),
            ),
          ),

          ElevatedButton(onPressed: () {}, child: Text('Add')),
        ],
      );
    },
  );
}
