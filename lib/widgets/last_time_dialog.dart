import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/boxes.dart';
import 'package:flutter_exam_mid/models/activity.dart';
import 'package:flutter_exam_mid/models/history.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class LastTimeDialog extends StatefulWidget {
  final Activity? lastTime;
  final Function(String name, String categoty) onClickedDone;

  const LastTimeDialog({
    Key? key,
    this.lastTime,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _LastTimeDialogState createState() => _LastTimeDialogState();
}

class _LastTimeDialogState extends State<LastTimeDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'History';
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ValueListenableBuilder<Box<Activity>>(
              valueListenable: Boxes.getActivities().listenable(),
              builder: (context, box, _) {
                final histories = box.values.toList().cast<History>();
                return buildContent(histories);
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        buildOkButton(context),
      ],
    );
  }

  Widget buildContent(List<History> histories) {
    if (histories.isEmpty) {
      return Text(
        'No Histories!',
      );
    } else {
      return Text('amount: ' + histories.length.toString());
    }
  }

  Widget buildOkButton(BuildContext context) => TextButton(
        child: Text('Ok'),
        onPressed: () => Navigator.of(context).pop(),
      );
}
