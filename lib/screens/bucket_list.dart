import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reality_shift/imports.dart';

class BucketList extends StatefulWidget {
  const BucketList({super.key});

  @override
  State<BucketList> createState() => _BucketListState();
}

class _BucketListState extends State<BucketList> {
  // List items = [];
  String currentTab = "all";
  // set things here  if you don't want it to keep rebuilding
  TextEditingController textCt = TextEditingController();
  final int maxTitleLength = 70; // Set your desired maximum length here

  void _addToList(ref) {
    textCt.text = "";
    final task = ref.read(BucketListProvider.notifier).state;
    CreateNew.showFolderDialog(
      context,
      name: "Add to Bucket List",
      hint: "name of event",
      first_action: "Add",
      inputCt: textCt,
      onpressed: () {
        if (textCt.text == "") return;
        if (textCt.text.length <= maxTitleLength) {
          setState(() {
            task.add({
              "status": "undone",
              "title": textCt.text,
              "isCompleted": false,
            });
            Navigator.of(context).pop();
          });
        } else {
          // Show warning message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Title cannot be more than $maxTitleLength characters',
              ),
            ),
          );
        }
      },
    );
  }

  void editText(Map<String, dynamic> index, ref) {
    textCt.text = index["title"];
    final task = ref.read(BucketListProvider.notifier).state;

    CreateNew.showFolderDialog(
      context,
      name: "Edit Task",
      hint: "name of event",
      inputCt: textCt,
      first_action: "Edit",
      second_action: "Delete",
      option: () {
        print("object");
        setState(() {
          // removeAt for int
          task.remove(index); // Remove item at the specified index
          Navigator.of(context).pop();
        });
      },
      onpressed: () {
        if (textCt.text == "") return;

        if (textCt.text.length <= maxTitleLength) {
          setState(() {
            // task;
            index["title"] = textCt.text;
            Navigator.of(context).pop();
          });
        } else {
          // Show warning message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Title cannot be more than $maxTitleLength characters',
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color black = Colors.black;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/cards/bridge.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Consumer(builder: (context, ref, _) {
          final items = ref.watch(BucketListProvider.notifier).state;
          print(items);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
                onPressed: () {
                  _addToList(ref);
                }),
            backgroundColor: Colors.transparent,
            appBar:
                CustomAppBar().bgImgbar(context, "Create your Bucket List:"),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 22.h,
                          child: Lottie.asset(
                              "lib/assets/images/lottie/todo.json")),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentTab = "done";
                              });
                              // print(currentTab);
                            },
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 22,
                                  backgroundColor:
                                      Color.fromARGB(255, 0, 255, 8),
                                  child: Icon(
                                    Icons.done_all_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("View Completed",
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17.sp)),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentTab = "all";
                              });
                              // print(currentTab);
                            },
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.amber,
                                  child: Icon(
                                    Icons.bookmarks_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                Text("View all",
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17.sp)),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentTab = "undone";
                              });
                              // print(currentTab);
                            },
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.gpp_maybe,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("View Uncompleted",
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17.sp)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: Column(
                        children: [
                          if (items.isEmpty)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: const Color(0xFF600600),
                                  child: Icon(
                                    Icons.pause,
                                    size: 10.h,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                    "You need to add tasks before you see your list...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 19.sp)),
                              ],
                            ),
                          if (currentTab == "all") _buildAllTasks(ref, items),
                          if (currentTab == "done")
                            _buildCompletedTasks(ref, items),
                          if (currentTab == "undone")
                            _buildUncompletedTasks(ref, items),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAllTasks(ref, items) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 7 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0),
      itemCount: items.length,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Prevents nested scrolling

      itemBuilder: (context, index) {
        final item = items[index];
        final title = item["title"];
        return Row(
          children: [
            Checkbox(
                // activeColor: Colors.white,
                // checkColor: Colors.black,
                value: item["isCompleted"],
                onChanged: (value) {
                  setState(() {
                    item["isCompleted"] = value;
                    item["status"] = value! ? "done" : "undone";
                  });
                  print(item["isCompleted"]);
                }),
            Flexible(
              child: Text(title,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                editText(item, ref);
              },
              child: const CircleAvatar(
                radius: 12,
                child: Icon(
                  Icons.edit,
                  // color: Colors.white,
                  size: 15,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildCompletedTasks(ref, items) {
    dynamic completed = items.where((item) => item["status"] == "done");
    dynamic list = completed.toList();
    // print(list);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 7 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0),
      itemCount: completed.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = list[index];
        // print(item);
        final title = item["title"];
        return Row(
          children: [
            Checkbox(
                value: item["isCompleted"],
                onChanged: (value) {
                  setState(() {
                    item["isCompleted"] = value;
                    item["status"] = value! ? "done" : "undone";
                  });
                  // print(item["isCompleted"]);
                }),
            Flexible(
              child: Text(title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    overflow: TextOverflow.visible,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                editText(item, ref);
              },
              child: const CircleAvatar(
                radius: 12,
                child: Icon(
                  Icons.edit,
                  // color: Colors.white,
                  size: 15,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildUncompletedTasks(ref, items) {
    dynamic uncompleted = items.where((item) => item["status"] == "undone");
    dynamic list = uncompleted.toList();
    // print(list);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 7 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0),
      itemCount: uncompleted.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = list[index];
        // print(item);
        final title = item["title"];
        return Row(
          children: [
            Checkbox(
                value: item["isCompleted"],
                onChanged: (value) {
                  setState(() {
                    item["isCompleted"] = value;
                    item["status"] = value! ? "done" : "undone";
                  });
                  // print(item["isCompleted"]);
                }),
            Flexible(
              child: Text(title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    overflow: TextOverflow.visible,
                  )),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                editText(item, ref);
              },
              child: const CircleAvatar(
                radius: 12,
                child: Icon(
                  Icons.edit,
                  // color: Colors.white,
                  size: 15,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
