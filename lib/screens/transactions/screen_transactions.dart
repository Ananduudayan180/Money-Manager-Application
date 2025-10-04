import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 38,
              child: Text(
                'Oct\n4',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            title: Text('RS 1000'),
            subtitle: Text('income'),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return SizedBox(height: 10);
      },
      itemCount: 30,
    );
  }
}
