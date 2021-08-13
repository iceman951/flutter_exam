import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/widgets/activity_dialog.dart';
import 'package:flutter_exam_mid/boxes.dart';
import 'package:flutter_exam_mid/models/activity.dart';
import 'package:flutter_exam_mid/models/history.dart';
import 'package:flutter_exam_mid/widgets/last_time_dialog.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  String dropdownValue = 'Categories';
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
            if (dropdownValue == 'Bill') {
              final billActivities =
                  activities.where((it) => it.category == 'Bill').toList();
              return buildContent(billActivities);
            } else if (dropdownValue == 'HomeWork') {
              final homeWorkActivities =
                  activities.where((it) => it.category == 'HomeWork').toList();
              return buildContent(homeWorkActivities);
            } else if (dropdownValue == 'Event') {
              final eventActivities =
                  activities.where((it) => it.category == 'Event').toList();
              return buildContent(eventActivities);
            } else
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
      return Column(children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildDropdown(context),
              SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                  child: Icon(Icons.history),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/history_page'))
            ],
          ),
        ),
        Center(child: Text('No Avtivity', style: TextStyle(fontSize: 24)))
      ]);
    } else {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildDropdown(context),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                    child: Icon(Icons.history),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/history_page'))
              ],
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

  Widget buildDropdown(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Categories', 'HomeWork', 'Event', 'Bill']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Done'),
              icon: Icon(Icons.done),
              onPressed: () => {
                addHistory(DateTime.now(), activity),
                Navigator.pushNamed(context, '/history_page')
              },
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Last Time'),
              icon: Icon(Icons.history_toggle_off_sharp),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => LastTimeDialog(
                  onClickedDone: (String name, String categoty) {},
                ),
              ),
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

  Future addHistory(DateTime createdDate, Activity activity) async {
    final history = History()
      ..createdDate = DateTime.now()
      ..activity = activity;
    final box = Boxes.getHistories();
    box.add(history);
  }
}
