import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/models/activity.dart';
import 'package:flutter_exam_mid/models/history.dart';
import 'package:flutter_exam_mid/pages/activity_page.dart';
import 'package:flutter_exam_mid/pages/history_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ActivityAdapter());
  Hive.registerAdapter(HistoryAdapter());
  await Hive.openBox<Activity>('activities');
  await Hive.openBox<History>('histories');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: ActivityPage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/history_page': (context) => HistoryPage(),
      },
    );
  }
}
