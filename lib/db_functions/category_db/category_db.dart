import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category_model/category_model.dart';

abstract class CategoryDbFunctions {}

class CategoryDb implements CategoryDbFunctions {
  initializeFlutter() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
      Hive.registerAdapter(CategoryTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
      Hive.registerAdapter(CategoryModelAdapter());
    }
  }
}
