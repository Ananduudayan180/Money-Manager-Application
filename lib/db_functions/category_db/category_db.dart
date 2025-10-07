import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category_model/category_model.dart';

const boxName = 'categoryDB';

abstract class CategoryDbFunctions {
  Future<void> insertCategory(CategoryModel value);
}

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

  CategoryDb._internal();
  static final CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDb = await Hive.openBox<CategoryModel>(boxName);
    categoryDb.add(value);
  }
}
