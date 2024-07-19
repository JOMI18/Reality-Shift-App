import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:reality_shift/imports.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({super.key});

  @override
  State<AllNotes> createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  List notes = [
    {
      "key": "Fashion in Korea",
      "value": "Buy this Jacket for me and pam",
      "date": DateFormat('MM/dd/yyyy')
          .format(DateTime.now().subtract(Duration(days: 50))),
    },
    {
      "key": "Meals in Nigeria",
      "value":
          "Try to eat as much Amala and Soup, try to bring Kuli - Kuli too",
      "date": DateFormat('MM/dd/yyyy')
          .format(DateTime.now().subtract(Duration(days: 20)))
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            notes.add({
              "key": "",
              "value": "",
              "date": DateFormat('MM/dd/yyyy').format(DateTime.now()),
            });
          });
        },
        child: Icon(Icons.add),
      ),
    
      appBar: CustomAppBar().generalbar(context, "Recent Notifications:"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ListView.builder(
                itemCount: notes.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final key = notes[index]["key"];
                  final value = notes[index]["value"];
                  final date = notes[index]["date"];
                  return Card(
                    color: Colors.black,
                    shape: const RoundedRectangleBorder(
                        side: const BorderSide(width: 2, color: Colors.teal),
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 22,
                                      backgroundImage: AssetImage(
                                          "lib/assets/images/cards/veggies.jpg"),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      child: Text(
                                        "You added a note on $key",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.more_horiz_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 90.w,
                            height: 20.h,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 114, 114, 114),
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(6))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 17.sp),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Date Posted: ${date.toString()}"),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
