import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jadwalku/models/task_model.dart';
import 'package:jadwalku/models/timeline_model.dart';
import 'package:jadwalku/providers/timeline_provider.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class SingleTimeline extends StatefulWidget {
  const SingleTimeline({Key? key}) : super(key: key);

  @override
  State<SingleTimeline> createState() => _SingleTimelineState();
}

class _SingleTimelineState extends State<SingleTimeline> {
  IndicatorStyle indicatorStyle = IndicatorStyle.outlined;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 20.0,
      ),
      child: Consumer<TimelineProvider>(
          builder: (BuildContext context, value, child) {
        DateFormat dateFormat = DateFormat("dd-MM-yyyy");
        String dateTime = dateFormat.format(DateTime.now());

        DateFormat dateFormatTask = DateFormat("HH:MM");

        if (value.isTimelineExist(dateTime)) {
          TimelineModel currentTimeline = value.getTimelineById(dateTime);

          return SingleChildScrollView(
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
                          size: 25.0,
                          position: 0.5,
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .selectedItemColor,
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
                        style: TextStyle(
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .unselectedItemColor,
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
                              style: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                              ),
                            ),
                            Text(
                              "${dateFormatTask.format(task.startTime)} - ${dateFormatTask.format(task.endTime)}",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            if (!task.isComplete) {
                              indicatorStyle = IndicatorStyle.dot;
                            } else {
                              indicatorStyle = IndicatorStyle.outlined;
                            }
                          });

                          Provider.of<TimelineProvider>(context, listen: false)
                              .toggleCompleteTask(currentTimeline.id, task);
                        },
                        icon: !task.isComplete
                            ? Icon(
                                Icons.toggle_off,
                                size: 26.0,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                              )
                            : Icon(
                                Icons.toggle_on,
                                size: 26.0,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .selectedItemColor,
                              ),
                      ),
                    ),
                  );
                },
                itemCount: currentTimeline.timelines.length,
                indicatorStyle: indicatorStyle,
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
