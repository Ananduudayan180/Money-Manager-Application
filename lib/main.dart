import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/db_functions/transactions_db/transaction_db.dart';
import 'package:money_manager/screens/home/screen_home.dart';
import 'package:money_manager/screens/transactions/add_transactions/add_transactions_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CategoryDb().initializeFlutter();
  await TransactionDb().transactionInitializeFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: ScreenHome(),
      routes: {
        'AddTransactionsScreen': (ctx) {
          return const AddTransactionsScreen();
        },
      },
    );
  }
}
