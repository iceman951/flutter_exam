import 'package:flutter/material.dart';
import 'package:flutter_exam_mid/boxes.dart';
import 'package:flutter_exam_mid/models/history.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late bool _sortDate;
  void initState() {
    _sortDate = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: ValueListenableBuilder<Box<History>>(
          valueListenable: Boxes.getHistories().listenable(),
          builder: (context, box, _) {
            final histories = box.values.toList().cast<History>();

            return buildContent(histories);
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.sort),
            onPressed: () => {
                  setState(() => {_sortDate = !_sortDate})
                }));
  }

  Widget buildContent(List<History> histories) {
    if (histories.isEmpty) {
      return Center(
        child: Text(
          'No Histories!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: histories.length,
              itemBuilder: (BuildContext context, int index) {
                if (_sortDate) {
                  histories.sort((a, b) {
                    var adate = a.createdDate;
                    var bdate = b.createdDate;
                    return adate.compareTo(bdate);
                  });
                } else {
                  histories.sort((b, a) {
                    var adate = a.createdDate;
                    var bdate = b.createdDate;
                    return adate.compareTo(bdate);
                  });
                }
                final history = histories[index];

                return buildHistory(context, history);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildHistory(
    BuildContext context,
    History history,
  ) {
    final color = Colors.green;

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          history.activity.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: Text(
          'CreateDate: ' +
              DateFormat('dd-MM-yyyy – kk:mm').format(history.createdDate),
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
