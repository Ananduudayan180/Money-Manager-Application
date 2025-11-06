import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/transactions_model/transaction_model.dart';

const boxName = 'transactionDB';

abstract class TransactionDbFunctions {
  Future<void> insertTransaction(TransactionModel value);
}

class TransactionDb implements TransactionDbFunctions {
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
    newTransactionListNotifier.value.add(value);
  }
}
