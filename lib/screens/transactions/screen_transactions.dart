import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/db_functions/transactions_db/transaction_db.dart';
import 'package:money_manager/models/transactions_model/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb().refreshUI();
    CategoryDb().refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDb().newTransactionListNotifier,
      builder:
          (BuildContext context, List<TransactionModel> transactions, child) {
            return ListView.separated(
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final newTransaction = transactions[index];
                String date = formatDate(newTransaction);
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 38,
                      child: Text(
                        date,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                    ),
                    title: Text('RS. ${newTransaction.amount}'),
                    subtitle: Text(newTransaction.category.name),
                    trailing: IconButton(
                      onPressed: () {
                        TransactionDb().deleteTransaction(newTransaction);
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(height: 10);
              },
              itemCount: transactions.length,
            );
          },
    );
  }

  String formatDate(TransactionModel newTransaction) {
    final dateTime = newTransaction.date.toString();
    final splitedDate = dateTime.split(' ')[0];
    final DateTime date = DateTime.parse(splitedDate);
    final format = DateFormat().add_MMMd();
    final formattedDate = format.format(date).split(' ');

    return '${formattedDate.last}\n${formattedDate.first}';
  }
}
