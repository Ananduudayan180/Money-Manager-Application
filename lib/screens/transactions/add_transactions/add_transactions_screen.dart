import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';
import 'package:money_manager/models/transactions_model/transaction_model.dart';

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
  DateTime? pickedDate;
  CategoryModel? selectedCategoryModel;
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
                            onTap: () {
                              selectedCategoryModel = value;
                            },
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
                    onPressed: () {
                      addNewTransaction();
                    },
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
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now().add(Duration(days: 3)),
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

  void addNewTransaction() {
    double amount;
    final purposeText = _purposeController.text;
    final amountText = _amountController.text;
    if (purposeText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }
    if (_dropdownValue == null) {
      return;
    }
    if (_selectedDate == 'Select Date') {
      return;
    }
    try {
      amount = double.parse(amountText);
    } catch (e) {
      return;
    }

    final transaction = TransactionModel(
      purpose: purposeText,
      amount: amount,
      date: pickedDate!,
      type: _selectedRadioButton,
      category: selectedCategoryModel!,
    );
    Navigator.of(context).pop();
  }
}
