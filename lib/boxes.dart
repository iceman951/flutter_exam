import 'package:flutter_exam_mid/models/activity.dart';
import 'package:hive/hive.dart';

import 'models/history.dart';

class Boxes {
  static Box<Activity> getActivities() => Hive.box<Activity>('activities');
  static Box<History> getHistories() => Hive.box<History>('histories');
}
