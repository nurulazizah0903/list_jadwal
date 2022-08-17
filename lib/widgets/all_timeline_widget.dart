import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

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
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 7",
            description: "Description of task 4",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 8",
            description: "Description of task 5",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 9",
            description: "Description of task 6",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 10",
            description: "Description of task 4",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 11",
            description: "Description of task 5",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 12",
            description: "Description of task 6",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 13",
            description: "Description of task 4",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 14",
            description: "Description of task 5",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 15",
            description: "Description of task 6",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 16",
            description: "Description of task 4",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 17",
            description: "Description of task 5",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 18",
            description: "Description of task 6",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 19",
            description: "Description of task 4",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 20",
            description: "Description of task 5",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
          TaskModel(
            id: DateTime.now().toString(),
            title: "Task 21",
            description: "Description of task 6",
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isComplete: false,
          ),
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
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Expanded(
                      child: FixedTimeline.tileBuilder(
                    theme: TimelineTheme.of(context).copyWith(
                      nodePosition: 0,
                      connectorTheme:
                          TimelineTheme.of(context).connectorTheme.copyWith(
                                thickness: 2.5,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .selectedItemColor,
                              ),
                      indicatorTheme:
                          TimelineTheme.of(context).indicatorTheme.copyWith(
                                size: 20.0,
                                position: 0.5,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .selectedItemColor,
                              ),
                    ),
                    builder: TimelineTileBuilder.connectedFromStyle(
                      contentsAlign: ContentsAlign.basic,
                      contentsBuilder: (context, index) {
                        TaskModel task = item.value.timelines[index];

                        return ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.description),
                        );
                      },
                      connectorStyleBuilder: (context, index) =>
                          ConnectorStyle.solidLine,
                      indicatorStyleBuilder: (context, index) =>
                          IndicatorStyle.dot,
                      itemCount: item.value.timelines.length,
                    ),
                  )),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
