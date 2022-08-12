import 'package:flutter/material.dart';
import './input_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff071d5b),
          primaryColor: Color(0x071D5BFF)),
      home: SafeArea(
        child: InputPage(),
      ),
    );
  }
}
