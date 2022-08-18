import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../widgets/single_timeline.dart';
import '../providers/timeline_provider.dart';
import '../widgets/cupertino_theme_widget.dart';
// import '../widgets/all_timeline_widget.dart';
import '../widgets/text_form_field_widget.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController taskNameController = TextEditingController();
    TextEditingController taskDescriptionController = TextEditingController();

    // DateTime startTime = DateTime.now();
    // DateTime endTime = DateTime.now();

    String startTime = "";
    String endTime = "";

    DateFormat dateFormat = DateFormat("HH:MM");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Timeline"),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: const SingleTimeline(),
      // body: const AllTimelineWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, setState) {
                  return AlertDialog(
                    title: const Text(
                      "Tambah Kegiatan",
                      textAlign: TextAlign.center,
                    ),
                    content: SizedBox(
                      height: 250.0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormFieldWidget(
                              controller: taskNameController,
                              hint: "Masukan nama kegiatan",
                              label: "Nama Kegiatan",
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormFieldWidget(
                              controller: taskDescriptionController,
                              hint: "Masukan deskripsi kegiatan",
                              label: "Deskripsi Kegiatan",
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 200.0,
                                                  child: CupertinoThemeWidget(
                                                    brightness:
                                                        Theme.of(context)
                                                            .brightness,
                                                    childWidget:
                                                        CupertinoDatePicker(
                                                      initialDateTime:
                                                          DateTime.now(),
                                                      onDateTimeChanged: (val) {
                                                        setState(() {
                                                          startTime =
                                                              val.toString();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                CupertinoThemeWidget(
                                                  brightness: Theme.of(context)
                                                      .brightness,
                                                  childWidget: CupertinoButton(
                                                    child: const Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text(
                                    "Waktu Mulai",
                                  ),
                                ),
                                Text(
                                  startTime.isEmpty
                                      ? "--:--"
                                      : dateFormat.format(
                                          DateTime.parse(startTime),
                                        ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 200.0,
                                                  child: CupertinoThemeWidget(
                                                    brightness:
                                                        Theme.of(context)
                                                            .brightness,
                                                    childWidget:
                                                        CupertinoDatePicker(
                                                      initialDateTime:
                                                          DateTime.now(),
                                                      onDateTimeChanged: (val) {
                                                        setState(() {
                                                          endTime =
                                                              val.toString();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                CupertinoThemeWidget(
                                                  brightness: Theme.of(context)
                                                      .brightness,
                                                  childWidget: CupertinoButton(
                                                    child: const Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text(
                                    "Waktu Akhir",
                                  ),
                                ),
                                Text(
                                  endTime.isEmpty
                                      ? "--:--"
                                      : dateFormat.format(
                                          DateTime.parse(endTime),
                                        ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Batalkan",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          TaskModel task = TaskModel(
                            id: DateTime.now().toString(),
                            title: taskNameController.text,
                            description: taskDescriptionController.text,
                            startTime: DateTime.parse(startTime),
                            endTime: DateTime.parse(endTime),
                            isComplete: false,
                          );

                          Provider.of<TimelineProvider>(context, listen: false)
                              .addNewTimeline(task);

                          startTime = "";
                          endTime = "";
                          taskNameController.clear();
                          taskDescriptionController.clear();

                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "OK",
                        ),
                      )
                    ],
                  );
                });
              });
        },
        // backgroundColor:
        //     Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
