import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/db_functions/transactions_db/transaction_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';
import 'package:money_manager/models/transactions_model/transaction_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> gradient = [const Color(0xFF3F51B5), const Color(0xFF00BCD4)];

    TransactionDb().refreshUI();
    CategoryDb().refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDb().newTransactionListNotifier,
      builder:
          (BuildContext context, List<TransactionModel> transactions, child) {
            return CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  title: Text(
                    "TRANSACTIONS",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.9),
                      // fontFamily: 'Montserrat',
                    ),
                  ),
                  flexibleSpace: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 135),
                      child: Text(
                        "TRANSACTIONS",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 25,
                          // fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 150,

                  // backgroundColor: Color(0xFF8E44AD),
                  backgroundColor: Colors.white,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, index) {
                      final newTransaction = transactions[index];
                      String date = formatDate(newTransaction);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (ctx) {
                                  TransactionDb().deleteTransaction(
                                    newTransaction,
                                  );
                                },
                                icon: Icons.delete,
                                label: 'Delete',
                                backgroundColor: const Color(0xFFFE4A49),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              // gradient: LinearGradient(
                              //   colors: [
                              //     Colors.purple,
                              //     Colors.deepOrangeAccent,
                              //   ],
                              // ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),

                            child: ListTile(
                              leading: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                  // gradient: LinearGradient(
                                  //   colors: [Colors.black26, Colors.white],
                                  // ),
                                ),
                                child: Text(
                                  date,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              title: Text(
                                '₹${newTransaction.amount}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      newTransaction.type == CategoryType.income
                                      ? const Color(0xFF21C55D)
                                      : const Color(0xFFEF4444),
                                ),
                              ),
                              subtitle: Text(
                                newTransaction.purpose,
                                style: const TextStyle(color: Colors.black54),
                              ),

                              trailing: Icon(
                                userIcons(newTransaction.category.name),
                                // color: Color(0xFF006FAD),
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      );
                    }, childCount: transactions.length),
                  ),
                ),
              ],
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

  IconData userIcons(String category) {
    switch (category.toLowerCase().trim()) {
      // Income
      case 'salary':
        return PhosphorIconsRegular.wallet;
      case 'freelance':
        return PhosphorIconsRegular.briefcase;
      case 'business':
      case 'businessprofit':
        return PhosphorIconsRegular.chartLineUp;
      case 'bonus':
        return PhosphorIconsRegular.gift;
      case 'rentincome':
      case 'rent':
        return PhosphorIconsRegular.house;
      case 'gift':
        return PhosphorIconsRegular.gift;
      case 'cashback':
        return PhosphorIconsRegular.coins;
      case 'investmentreturns':
        return PhosphorIconsRegular.trendUp;

      // Expense
      case 'food':
        return PhosphorIconsRegular.forkKnife;
      case 'shopping':
        return PhosphorIconsRegular.shoppingCart;
      case 'fuel':
        return PhosphorIconsRegular.gasPump;
      case 'emi':
        return PhosphorIconsRegular.receipt;
      case 'entertainment':
        return PhosphorIconsRegular.gameController;
      case 'clothes':
        return PhosphorIconsRegular.tShirt;
      case 'fees':
      case 'education':
        return PhosphorIconsRegular.bookOpen;
      case 'travel':
        return PhosphorIconsRegular.airplane;
      case 'groceries':
        return PhosphorIconsRegular.basket;
      case 'health':
      case 'medicine':
        return PhosphorIconsRegular.firstAid;
      case 'vehicle':
        return PhosphorIconsRegular.car;
      case 'bills':
      case 'utilities':
        return PhosphorIconsRegular.lightbulb;
      case 'donation':
        return PhosphorIconsRegular.handHeart;
      case 'others':
      case 'miscellaneous':
        return PhosphorIconsRegular.gridFour;
      default:
        return PhosphorIconsRegular.shoppingCart;
    }
  }
}
