import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/all_timeline_widget.dart';
import '../widgets/text_form_field_widget.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController taskNameController = TextEditingController();
    TextEditingController taskDescriptionController = TextEditingController();

    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.now();

    DateFormat dateFormat = DateFormat("HH:MM");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Timeline"),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: AllTimelineWidget(),
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
                                                  child: CupertinoDatePicker(
                                                      initialDateTime:
                                                          DateTime.now(),
                                                      onDateTimeChanged: (val) {
                                                        setState(() {
                                                          startTime = val;
                                                        });
                                                      }),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                CupertinoButton(
                                                    child: const Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    })
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  style: TextButton.styleFrom(
                                    primary: Colors.grey.shade400,
                                    backgroundColor: Colors.grey.shade200,
                                  ),
                                  child: Text(
                                    "Waktu Mulai",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                Text(dateFormat.format(startTime)),
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
                                                  child: CupertinoDatePicker(
                                                      initialDateTime:
                                                          DateTime.now(),
                                                      onDateTimeChanged: (val) {
                                                        setState(() {
                                                          endTime = val;
                                                        });
                                                      }),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                CupertinoButton(
                                                    child: const Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    })
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  style: TextButton.styleFrom(
                                    primary: Colors.grey.shade400,
                                    backgroundColor: Colors.grey.shade200,
                                  ),
                                  child: Text(
                                    "Waktu Akhir",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                Text(dateFormat.format(endTime)),
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
                          // Navigator.of(context).pop();

                          print(taskNameController.text);
                          print(taskDescriptionController.text);
                          print(startTime);
                          print(endTime);
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
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
