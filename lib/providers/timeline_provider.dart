import 'package:flutter/material.dart';
import 'package:jadwalku/models/task_model.dart';

class TimelineProvider with ChangeNotifier {
  Map<DateTime, TaskModel> _timelines = {};
}
