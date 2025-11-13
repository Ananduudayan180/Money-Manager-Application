import 'package:flutter/material.dart';
import 'package:money_manager/db_functions/category_db/category_db.dart';
import 'package:money_manager/models/category_model/category_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryListNotifier,
      builder: (BuildContext context, List<CategoryModel> category, child) {
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFE8EAED), //0xFFE8EAED
              ),
              child: ListTile(
                title: Text(category[index].name),
                trailing: IconButton(
                  onPressed: () {
                    final id = category[index].id;
                    CategoryDb().deleteCategory(id);
                  },
                  icon: const Icon(
                    PhosphorIconsRegular.trashSimple,
                    color: Color(0xFFF44336),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 15);
          },
          itemCount: category.length,
        );
      },
    );
  }
}
