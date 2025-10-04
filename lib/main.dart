import 'package:flutter/material.dart';
import 'package:money_manager/home/screens/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const ScreenHome(),
    );
  }
}
