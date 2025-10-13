import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';

class AddTransactionsScreen extends StatefulWidget {
  const AddTransactionsScreen({super.key});

  @override
  State<AddTransactionsScreen> createState() => _AddTransactionsScreenState();
}

class _AddTransactionsScreenState extends State<AddTransactionsScreen> {
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedDate = 'Select Date';
  CategoryType _selectedRadioButton = CategoryType.income;
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Transaction',
          style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _purposeController,
                  decoration: InputDecoration(
                    labelText: 'Purpose',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  datePicker(context);
                },
                child: Text(_selectedDate),
              ),
              RadioGroup(
                groupValue: _selectedRadioButton,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  } else {
                    setState(() {
                      _dropdownValue = null;
                      _selectedRadioButton = value;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio<CategoryType>(value: CategoryType.income),
                        Text('Income'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<CategoryType>(value: CategoryType.expense),
                        Text('Expense'),
                      ],
                    ),
                  ],
                ),
              ),
              DropdownButton(
                hint: Text('Select category', style: TextStyle(fontSize: 15)),
                value: _dropdownValue,
                items:
                    (_selectedRadioButton == CategoryType.income
                            ? CategoryDb().incomeCategoryListNotifier
                            : CategoryDb().expenseCategoryListNotifier)
                        .value
                        .map((value) {
                          return DropdownMenuItem(
                            value: value.name,
                            child: Text(value.name),
                          );
                        })
                        .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _dropdownValue = value;
                  });
                },
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  datePicker(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025, 9, 10),
      lastDate: DateTime(2025, 10, 15),
    );

    if (pickedDate != null) {
      String pickedDateString = pickedDate.toString();
      setState(() {
        _selectedDate = pickedDateString.split(' ')[0];
      });
    } else {
      setState(() {
        _selectedDate = 'Select Date';
      });
    }
  }
}
