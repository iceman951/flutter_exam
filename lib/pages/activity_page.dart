import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/activity_dialog.dart';
import 'package:flutter_exam_mid/boxes.dart';
import 'package:flutter_exam_mid/models/activity.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final searchController = TextEditingController();

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

  Widget buildContent(List<Activity> activities) {
    if (activities.isEmpty) {
      return Center(
        child: Text(
          'No Activity!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40,
                  width: 160,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchController.text = value;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Search'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                    child: Icon(Icons.search), onPressed: () => {})
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [Text('Activity'), Text('Activity2')],
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: activities.length,
              itemBuilder: (BuildContext context, int index) {
                final activity = activities[index];

                return buildActivity(context, activity);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildActivity(
    BuildContext context,
    Activity activity,
  ) {
    final color = Colors.green;

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          activity.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: Text(
          'CreateDate: ' +
              DateFormat('dd-MM-yyyy – kk:mm').format(activity.createdDate),
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, activity),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Activity activity) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ActivityDialog(
                    activity: activity,
                    onClickedDone: (name, category) =>
                        editActivity(activity, name, category),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: () => deleteActivity(activity),
            ),
          )
        ],
      );

  Future addActivity(String name, String category) async {
    final activity = Activity()
      ..name = name
      ..createdDate = DateTime.now()
      ..category = category;
    final box = Boxes.getActivities();
    box.add(activity);
  }

  void editActivity(Activity activity, String name, String category) {
    activity.name = name;
    activity.category = category;

    activity.save();
  }

  void deleteActivity(Activity activity) {
    activity.delete();
  }
}
