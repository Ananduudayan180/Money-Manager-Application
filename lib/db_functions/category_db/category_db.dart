import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category_model/category_model.dart';

const boxName = 'categoryDB';

abstract class CategoryDbFunctions {
  Future<void> insertCategory(CategoryModel value);
  Future<List<CategoryModel>> getCategories();
}

class CategoryDb extends ChangeNotifier implements CategoryDbFunctions {
  ValueNotifier<List<CategoryModel>> incomeCategoryListNotifier = ValueNotifier(
    [],
  );
  ValueNotifier<List<CategoryModel>> expenseCategoryListNotifier =
      ValueNotifier([]);

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
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDb = await Hive.openBox<CategoryModel>(boxName);
    return categoryDb.values.toList();
  }

  Future<void> refreshUI() async {
    final categoryList = await getCategories();
    incomeCategoryListNotifier.value.clear();
    expenseCategoryListNotifier.value.clear();
    await Future.forEach(categoryList, (category) async {
      if (category.type == CategoryType.income) {
        incomeCategoryListNotifier.value.add(category);
      } else {
        expenseCategoryListNotifier.value.add(category);
      }
    });
    incomeCategoryListNotifier.notifyListeners();
    expenseCategoryListNotifier.notifyListeners();
  }
}
