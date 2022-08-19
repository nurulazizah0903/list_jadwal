import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

import '../models/task_model.dart';
import '../models/timeline_model.dart';
import '../providers/timeline_provider.dart';

class SingleTimeline extends StatelessWidget {
  const SingleTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 20.0,
      ),
      child: Consumer<TimelineProvider>(
          builder: (BuildContext context, value, child) {
        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        String dateTime = dateFormat.format(DateTime.now());

        DateFormat dateFormatTask = DateFormat("HH:mm");

        if (value.isTimelineExist(dateTime)) {
          TimelineModel currentTimeline = value.getTimelineById(dateTime);

          return SingleChildScrollView(
            child: FixedTimeline.tileBuilder(
              theme: TimelineTheme.of(context).copyWith(
                nodePosition: 0,
                connectorTheme:
                    TimelineTheme.of(context).connectorTheme.copyWith(
                          thickness: 2.0,
                          color: Theme.of(context).primaryColor,
                        ),
                indicatorTheme:
                    TimelineTheme.of(context).indicatorTheme.copyWith(
                          size: 20.0,
                          position: 0.5,
                          color: Theme.of(context).primaryColor,
                        ),
              ),
              builder: TimelineTileBuilder.fromStyle(
                contentsAlign: ContentsAlign.basic,
                contentsBuilder: (context, index) {
                  TaskModel task = currentTimeline.timelines[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    child: ListTile(
                      title: Text(
                        task.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: task.isComplete
                            ? TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 4.0,
                                decorationColor: Theme.of(context).primaryColor,
                              )
                            : const TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              "${dateFormatTask.format(task.startTime)} - ${dateFormatTask.format(task.endTime)}",
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Provider.of<TimelineProvider>(context, listen: false)
                              .toggleCompleteTask(currentTimeline.id, task);
                        },
                        icon: !task.isComplete
                            ? const Icon(
                                Icons.toggle_off,
                                size: 35.0,
                              )
                            : Icon(
                                Icons.toggle_on,
                                size: 35.0,
                                color: Theme.of(context).primaryColor,
                              ),
                      ),
                    ),
                  );
                },
                itemCount: currentTimeline.timelines.length,
                indicatorStyle: IndicatorStyle.dot,
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
              "Kegiatan kamu hari ini masih kosong nih!",
              style: TextStyle(
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
            ),
          );
        }
      }),
    );
  }
}
