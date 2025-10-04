import 'package:flutter/material.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('RS +1560$index', style: TextStyle(color: Colors.green)),
          subtitle: Text('income'),
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
