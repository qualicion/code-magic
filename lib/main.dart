import 'package:flutter/material.dart';
import 'package:flutter_patrol_tutorial/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: LoginPage(),
    );
  }
}
