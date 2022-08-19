import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

import '../models/task_model.dart';
import '../services/hive_service.dart';

class AllTimelineWidget extends StatelessWidget {
  const AllTimelineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd MMMM, yyyy");

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<HiveService>(builder: ((context, value, child) {
        if (value.timelines.isNotEmpty) {
          return ListView(
            children: value.timelines.entries.map((item) {
              return Card(
                child: ExpansionTile(
                  title: ListTile(
                    title: Text(
                      dateFormat.format(DateTime.parse(item.key)),
                      style: const TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: FixedTimeline.tileBuilder(
                        theme: TimelineTheme.of(context).copyWith(
                          nodePosition: 0,
                          connectorTheme:
                              TimelineTheme.of(context).connectorTheme.copyWith(
                                    thickness: 1.5,
                                    color: Theme.of(context).primaryColor,
                                  ),
                          indicatorTheme:
                              TimelineTheme.of(context).indicatorTheme.copyWith(
                                    size: 15.0,
                                    position: 0.5,
                                    color: Theme.of(context).primaryColor,
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
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: Text("Wah, timeline kamu masih kosong nih!"),
          );
        }
      })),
    );
  }
}
