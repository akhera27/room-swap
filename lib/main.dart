import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'ContactPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Swap',
      home: ContactPage(),
      theme: new ThemeData(
        primaryColor: Colors.purple,
//        pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
      ),
    );
  }
}