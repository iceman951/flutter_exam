import 'package:flutter_exam_mid/models/activity.dart';
import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(0)
  late DateTime createdDate;

  @HiveField(1)
  late Activity activity;
}
