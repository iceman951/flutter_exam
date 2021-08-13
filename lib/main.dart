import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/models/activity.dart';
import 'package:flutter_exam_mid/pages/activity_page.dart';
import 'package:flutter_exam_mid/pages/list_page.dart';
import 'package:flutter_exam_mid/pages/second_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ActivityAdapter());
  await Hive.openBox<Activity>('activities');

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
      home: ActivityPage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/second_page': (context) => SecondPage(),
        '/list_page': (context) => ListPage(),
      },
    );
  }
}
