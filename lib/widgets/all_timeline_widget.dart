import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:jadwalku/widgets/single_timeline.dart';

import '../models/task_model.dart';
import '../models/timeline_model.dart';

class AllTimelineWidget extends StatelessWidget {
  const AllTimelineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd MMMM, yyyy - HH:mm");

    Map<String, TimelineModel> allTimelines = {
      DateTime.now().toString(): TimelineModel(
        id: DateTime.now().toString(),
        timelines: [
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 1",
            description: "Description of task 1",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 2",
            description: "Description of task 2",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          )
        ],
      ),
      DateTime.now().toString(): TimelineModel(
        id: DateTime.now().toString(),
        timelines: [
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 3",
            description: "Description of task 1",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
        ],
      ),
      DateTime.now().toString(): TimelineModel(
        id: DateTime.now().toString(),
        timelines: [
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 4",
            description: "Description of task 4",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 5",
            description: "Description of task 5",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 6",
            description: "Description of task 6",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          )
        ],
      ),
    };

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: allTimelines.entries.map((item) {
          return Card(
            child: ExpansionTile(
              title: ListTile(
                title: Text(
                  dateFormat.format(DateTime.parse(item.key)),
                ),
              ),
              children: item.value.timelines.map((task) {
                return ListTile(
                  title: Text(task.title),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
