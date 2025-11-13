import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/db_functions/transactions_db/transaction_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';
import 'package:money_manager/models/transactions_model/transaction_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddTransactionsScreen extends StatefulWidget {
  const AddTransactionsScreen({super.key});

  @override
  State<AddTransactionsScreen> createState() => _AddTransactionsScreenState();
}

class _AddTransactionsScreenState extends State<AddTransactionsScreen> {
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedDate = 'Select Date';
  CategoryType _selectedToggleButton = CategoryType.income;
  String? _dropdownValue;
  DateTime? pickedDate;
  CategoryModel? selectedCategoryModel;
  bool isIncome = true;
  List<Color> colors = [const Color(0xFF3F51B5), const Color(0xFF00BCD4)];
  Color focusedColor = const Color(0xFF0097A7);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(PhosphorIconsRegular.caretLeft),
        ),
        title: const Text(
          'NEW TRANSACTION',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 12, left: 12),
                child: Row(
                  children: [
                    Text(
                      'Purpose',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: _purposeController,
                  decoration: InputDecoration(
                    suffixIcon: ShaderMask(
                      shaderCallback: (bounds) =>
                          LinearGradient(colors: colors).createShader(bounds),
                      child: const Icon(
                        PhosphorIconsRegular.sparkle,
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Enter', //pursose
                    labelStyle: const TextStyle(fontSize: 15, color: Colors.black54),

                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black26),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusedColor),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Text(
                      'Enter Amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Enter', //amount
                    labelStyle: const TextStyle(fontSize: 15, color: Colors.black54),
                    suffixIcon: ShaderMask(
                      shaderCallback: (bounds) =>
                          LinearGradient(colors: colors).createShader(bounds),

                      child: const Icon(
                        PhosphorIconsRegular.currencyDollarSimple,
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(width: 1, color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusedColor),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _dropdownValue = null;
                            isIncome = true;
                            _selectedToggleButton = CategoryType.income;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: isIncome
                                ? LinearGradient(colors: colors)
                                : null,
                            color: isIncome ? Colors.white : null,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            border: !isIncome
                                ? Border.all(color: Colors.black26)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Income',
                              style: TextStyle(
                                color: isIncome ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _dropdownValue = null;
                            isIncome = false;
                            _selectedToggleButton = CategoryType.expense;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: !isIncome
                                ? LinearGradient(colors: colors)
                                : null,
                            color: !isIncome ? Colors.white : null,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            border: isIncome
                                ? Border.all(color: Colors.black26)
                                : null,
                          ),

                          child: Center(
                            child: Text(
                              'Expense',
                              style: TextStyle(
                                color: !isIncome ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),

                    //select date
                    OutlinedButton.icon(
                      icon: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: colors,
                          ).createShader(bounds);
                        },
                        child: const Icon(
                          PhosphorIconsRegular.calendar,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        datePicker(context);
                      },
                      label: Text(
                        _selectedDate,
                        style: const TextStyle(color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: const BorderSide(color: Colors.black26),
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      'Select Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: DropdownButtonFormField(
                  icon: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: colors,
                      ).createShader(bounds);
                    },
                    child: const Icon(
                      PhosphorIconsRegular.caretUpDown,
                      color: Colors.white,
                    ),
                  ),

                  hint: const Text(
                    'Select any category',
                    style: TextStyle(fontSize: 15),
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(width: 1, color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusedColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  initialValue: _dropdownValue,
                  items:
                      (_selectedToggleButton == CategoryType.income
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
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(colors: colors),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.transparent,
                      // surfaceTintColor: Colors.transparent,
                      // elevation: 4,
                    ),
                    onPressed: () {
                      addNewTransaction();
                    },
                    child: const Text(
                      'Submit transactions',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
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
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 3)),
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
    if (_selectedDate == '') {
      return;
    }
    if (pickedDate == null) {
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
      type: _selectedToggleButton,
      category: selectedCategoryModel!,
    );

    TransactionDb().insertTransaction(transaction);
    Navigator.of(context).pop();
  }
}
