import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/transactions_model/transaction_model.dart';

const boxName = 'transactionDB';

abstract class TransactionDbFunctions {
  Future<void> insertTransaction(TransactionModel value);
  Future<List<TransactionModel>> getTransactions();
  Future deleteTransaction(TransactionModel model);
}

class TransactionDb extends ChangeNotifier implements TransactionDbFunctions {
  ValueNotifier<List<TransactionModel>> newTransactionListNotifier =
      ValueNotifier([]);
  late Box<TransactionModel> _transactionBox;

  Future<void> transactionInitializeFlutter() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
      Hive.registerAdapter(TransactionModelAdapter());
    }
    _transactionBox = await Hive.openBox<TransactionModel>(boxName);
  }

  TransactionDb._internal();
  static final TransactionDb _instance = TransactionDb._internal();
  factory TransactionDb() {
    return _instance;
  }

  @override
  Future<void> insertTransaction(TransactionModel value) async {
    await _transactionBox.add(value);
    refreshUI();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final transactions = _transactionBox.values.toList();
    return transactions;
  }

  @override
  Future deleteTransaction(TransactionModel model) async {
    final transactioModel = model;
    final boxMap = _transactionBox.toMap();
    for (var map in boxMap.entries) {
      if (identical(transactioModel, map.value)) {
        await _transactionBox.delete(map.key);
        refreshUI();
        return;
      }
    }
  }

  Future refreshUI() async {
    final transactionsList = await getTransactions();
    newTransactionListNotifier.value.clear();
    transactionsList.sort((a, b) => b.date.compareTo(a.date));
    newTransactionListNotifier.value.addAll(transactionsList);
    newTransactionListNotifier.notifyListeners();
  }
}
