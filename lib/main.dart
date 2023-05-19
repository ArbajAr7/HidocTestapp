import 'package:flutter/material.dart';
import 'package:testapp/webHomePage.dart';

import 'mobileHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rest full Api call',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 700) {
            return const webHomePage(title: 'Articles');
          } else {
            return const mobileHomePage(title: 'Hidoc');
          }
        },
      ),
    );
  }
}