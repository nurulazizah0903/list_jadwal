import 'package:jadwalku/models/task_model.dart';

class TimelineModel {
  final String id;
  final List<TaskModel> timelines;

  TimelineModel({
    required this.id,
    required this.timelines,
  });
}
