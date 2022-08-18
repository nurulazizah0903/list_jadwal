import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';
import '../models/timeline_model.dart';

class TimelineProvider with ChangeNotifier {
  Map<String, TimelineModel> _timelines = {};

  // Mendapatkan timelines

  Map<String, TimelineModel> get timelines => _timelines;

  // Cek apakah id ada di timeline atau tidak.

  bool isTimelineExist(String id) {
    return _timelines.containsKey(id);
  }

  // Mendapatkan timeline berdasarkan id (tanggal hari ini).

  TimelineModel getTimelineById(String id) {
    return _timelines[id]!;
  }

  // Menambah sebuah timeline baru

  void addNewTimeline(TaskModel task) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String dateTime = dateFormat.format(DateTime.now());

    if (!_timelines.containsKey(dateTime)) {
      _timelines.putIfAbsent(
        dateTime,
        () => TimelineModel(
          id: dateTime,
          timelines: [
            task,
          ],
        ),
      );
    } else {
      _timelines.update(
        dateTime,
        (value) => TimelineModel(
          id: value.id,
          timelines: [
            ...value.timelines,
            task,
          ],
        ),
      );
    }

    notifyListeners();
  }

  void toggleCompleteTask(String timelineId, TaskModel task) {
    if (_timelines.containsKey(timelineId)) {
      _timelines.update(timelineId, (value) {
        TaskModel updatedTask = TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          startTime: task.startTime,
          endTime: task.endTime,
          isComplete: !task.isComplete,
        );

        value.timelines[value.timelines
            .indexWhere((element) => element.id == task.id)] = updatedTask;

        return TimelineModel(id: value.id, timelines: value.timelines);
      });
    }

    notifyListeners();
  }

  bool getTaskCompleteStatus(String timelineId, String taskId) {
    return _timelines[timelineId]!
        .timelines
        .firstWhere((element) => element.id == taskId)
        .isComplete;
  }
}
