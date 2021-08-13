import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/activity_dialog.dart';
import 'package:flutter_exam_mid/boxes.dart';
import 'package:flutter_exam_mid/models/activity.dart';
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

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Last Time'),
        ),
        body: ValueListenableBuilder<Box<Activity>>(
          valueListenable: Boxes.getActivities().listenable(),
          builder: (context, box, _) {
            final activities = box.values.toList().cast<Activity>();

            return buildContent(activities);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => ActivityDialog(
              onClickedDone: addActivity,
            ),
          ),
        ),
      );

  

  Future addActivity(String name) async {
    final activity = Activity()
      ..name = name
      ..createdDate = DateTime.now();

    final box = Boxes.getActivities();
    box.add(activity);
  }

  void editActivity(
    Activity activity,
    String name,
  ) {
    activity.name = name;

    activity.save();
  }

  void deleteActivity(Activity activity) {
    activity.delete();
  }
}
