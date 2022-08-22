import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'gif_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String appName = "GIF Finder";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.royalGreen,
          title: Text(appName),
          centerTitle: true,
        ),
        body: SafeArea(
          child: GifPage(),
        ),
      ),
    );
  }
}
