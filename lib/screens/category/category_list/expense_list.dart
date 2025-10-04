import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('RS -1960$index', style: TextStyle(color: Colors.red)),
          subtitle: Text('Expense'),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return Divider();
      },
      itemCount: 30,
    );
  }
}
