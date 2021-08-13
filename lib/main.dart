import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/pages/home.dart';
import 'package:flutter_exam_mid/pages/list_page.dart';
import 'package:flutter_exam_mid/pages/second_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
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
        '/list_page': (context) => ListPage(),
      },
    );
  }
}
