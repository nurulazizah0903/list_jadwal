import 'package:hive/hive.dart';

import '../models/task_model.dart';

part "timeline_model.g.dart";

@HiveType(typeId: 1)
class TimelineModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<TaskModel> timelines;

  TimelineModel({
    required this.id,
    required this.timelines,
  });
}
