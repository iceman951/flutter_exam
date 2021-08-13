import 'package:flutter_exam_mid/models/activity.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Activity> getActivitys() => Hive.box<Activity>('activities');
}
