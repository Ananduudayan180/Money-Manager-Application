import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category_model/category_model.dart';

const boxName = 'categoryDB';

abstract class CategoryDbFunctions {
  Future<void> insertCategory(CategoryModel value);
  Future<List<CategoryModel>> getCategories();
  Future<void> deleteCategory(String categoryID);
}

class CategoryDb extends ChangeNotifier implements CategoryDbFunctions {
  ValueNotifier<List<CategoryModel>> incomeCategoryListNotifier = ValueNotifier(
    [],
  );
  ValueNotifier<List<CategoryModel>> expenseCategoryListNotifier =
      ValueNotifier([]);

  late Box<CategoryModel> _categoryBox;

  initializeFlutter() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
      Hive.registerAdapter(CategoryTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
      Hive.registerAdapter(CategoryModelAdapter());
    }
    _categoryBox = await Hive.openBox<CategoryModel>(boxName);
  }

  CategoryDb._internal();
  static final CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }

  @override
  Future<void> insertCategory(CategoryModel value) async {
    _categoryBox.put(value.id, value);
    await refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return _categoryBox.values.toList();
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await _categoryBox.delete(categoryId);
    await refreshUI();
  }

  Future<void> refreshUI() async {
    final categoryList = await getCategories();
    incomeCategoryListNotifier.value.clear();
    expenseCategoryListNotifier.value.clear();
    for (var category in categoryList) {
      if (category.type == CategoryType.income) {
        incomeCategoryListNotifier.value.add(category);
      } else {
        expenseCategoryListNotifier.value.add(category);
      }
    }
    incomeCategoryListNotifier.notifyListeners();
    expenseCategoryListNotifier.notifyListeners();
  }
}
