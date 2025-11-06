import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/transactions_model/transaction_model.dart';

const boxName = 'transactionDB';

class TransactionDb {
  late Box<TransactionModel> _transactionBox;

  Future<void> transactionInitializeFlutter() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
      Hive.registerAdapter(TransactionModelAdapter());
    }
    _transactionBox = await Hive.openBox<TransactionModel>(boxName);
  }
}
