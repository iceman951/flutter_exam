import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('My Activities'),
        ),
      );
}
