import 'dart:collection';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../models/timeline_model.dart';

class HiveService extends ChangeNotifier {
  final String noteHiveBox = 'timelines-box';

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Map<String, TimelineModel> _timelines = {};

  UnmodifiableMapView<String, TimelineModel> get timelines =>
      UnmodifiableMapView(_timelines);

  // Menambah sebuah timeline baru

  Future<void> addNewTimeline(TaskModel task) async {
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

    Box<Map<String, TimelineModel>> box =
        await Hive.openBox<Map<String, TimelineModel>>(noteHiveBox);

    await box.clear();

    _timelines.entries.map((item) async {
      await box.add({
        item.key: item.value,
      });
    });

    notifyListeners();
  }

  Future<void> getTimelines() async {
    Box<Map<String, TimelineModel>> box =
        await Hive.openBox<Map<String, TimelineModel>>(noteHiveBox);

    // _timelines = box.values as Map<String, TimelineModel>;

    box.values.map((item) {
      _timelines = item;
    });

    notifyListeners();
  }

  // Cek apakah id ada di timeline atau tidak.

  bool isTimelineExist(String id) {
    return _timelines.containsKey(id);
  }

  // Mendapatkan timeline berdasarkan id (tanggal hari ini).

  TimelineModel getTimelineById(String id) {
    return _timelines[id]!;
  }

  Future<void> toggleCompleteTask(String timelineId, TaskModel task) async {
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

      Box<Map<String, TimelineModel>> box =
          await Hive.openBox<Map<String, TimelineModel>>(noteHiveBox);

      await box.clear();

      _timelines.entries.map((item) async {
        await box.add({
          item.key: item.value,
        });
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
