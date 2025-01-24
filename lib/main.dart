import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sheets App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
    );
  }
}
