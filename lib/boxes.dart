import 'package:flutter_exam_mid/models/activity.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Activity> getActivities() => Hive.box<Activity>('activities');
}
