import 'package:flutter/material.dart';

import 'screens/home_page.dart';
//  flutter build apk --split-per-abi

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black,
          bottomAppBarColor: Color(0xFFF6F7FB)),
      home: HomePage(),
    );
  }
}

