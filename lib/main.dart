import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/pages/home.dart';
import 'package:flutter_exam_mid/pages/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FrozenCodeMobile Demo',
      theme: ThemeData(
        // is not restarted.
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      // home: HomePage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => Home(),
        '/second_page': (context) => SecondPage(),
      },
    );
  }
}
