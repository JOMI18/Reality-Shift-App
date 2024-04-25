import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reality_shift/imports.dart';

class Panel extends StatefulWidget {
  const Panel({super.key});

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  final Random random = Random();
  late Timer timer;
  late StreamController<String> quoteController;
  late Stream<String> quoteStream;
  late String currentQuote;

  final date = DateFormat('MM/dd/yyyy').format(DateTime.now());
  final month = DateFormat("MMMM").format(DateTime.now());
  final year = DateFormat('yyyy').format(DateTime.now());
  final day = DateFormat('dd').format(DateTime.now());
  late String time;

  final List<String> quotes = [
    "The only way to achieve the impossible is to believe it is possible. - Charles Kingsleigh",
    "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. - Albert Schweitzer",
    "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt",
    "It does not matter how slowly you go as long as you do not stop. - Confucius",
    "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle. - Christian D. Larson",
    "The only limit to our realization of tomorrow will be our doubts of today. - Franklin D. Roosevelt",
    "You are never too old to set another goal or to dream a new dream. - C.S. Lewis",
    "The greatest glory in living lies not in never falling, but in rising every time we fall. - Nelson Mandela",
    "Success is not just about the destination, it's also about the journey. - Author Unknown",
    "Every moment is a fresh beginning. - T.S. Eliot",
    "Believe you can and you're halfway there. - Theodore Roosevelt",
    "The only way to do great work is to love what you do. - Steve Jobs",
    "In the middle of every difficulty lies opportunity. - Albert Einstein",
    "Don't watch the clock; do what it does. Keep going. - Sam Levenson",
    "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
    "Your limitation—it's only your imagination.",
    "Push yourself, because no one else is going to do it for you.",
    "Great things never come from comfort zones.",
    "Dream it. Wish it. Do it.",
    "Wake up with determination, go to bed with satisfaction.",
  ];

  List operations = [
    {"op": "Create", "route": "create_continent"},
    {"op": "Read", "route": ""},
    {"op": "Update", "route": ""},
    {"op": "Delete", "route": ""},
  ];

  String _getRandomQuote() {
    return quotes[random.nextInt(quotes.length)];
  }

  final List engagementData = [
    {
      "icon": Icons.run_circle_rounded,
      "title": 'Active Users',
      "number": 300,
      "bg": Color.fromARGB(255, 242, 255, 0),
      "route": "manage_users"
    },
    {
      "icon": Icons.people_alt_rounded,
      "title": 'New Users',
      "number": 150,
      "bg": const Color.fromARGB(255, 0, 140, 255),
      "route": "manage_users"
    },
    {
      "icon": Icons.restart_alt_rounded,
      "title": 'Returning Users',
      "number": 200,
      "bg": Color.fromARGB(255, 0, 255, 213),
      "route": "manage_users"
    },
    {
      "icon": Icons.volunteer_activism_outlined,
      "title": "Most Used by Females",
      "number": 100,
      "bg": const Color.fromARGB(255, 255, 0, 85),
      "route": ""
    },
    {
      "icon": Icons.align_vertical_bottom_sharp,
      "title": "Most common with Age Group 18-24",
      "number": 180,
      "bg": Color.fromARGB(255, 69, 69, 255),
      "route": ""
    },
  ];

  @override
  void initState() {
    super.initState();
    time = DateFormat('h:mm a').format(DateTime.now());

    currentQuote = _getRandomQuote();
    quoteController = StreamController<String>.broadcast();
    quoteStream = quoteController.stream;

    // Generate a new random quote every 2 minutes
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final newQuote = _getRandomQuote();

      quoteController.add(newQuote);
      setState(() {
        currentQuote = newQuote;
      });
    });

    Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        time = DateFormat('h:mm a').format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    quoteController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color rootcolor = Utilities().appColors(context).secondary;

    // print(day);

    return Scaffold(
      appBar: CustomAppBar().welcomebar(context, "Admin: Control System"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ComponentSlideIns(
                    beginOffset: Offset(-2, 0),
                    child: Card(
                      surfaceTintColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28.0, vertical: 4),
                            child: Text("Welcome, Oluwajomiloju!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 21.sp, color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ComponentSlideIns(
                        beginOffset: Offset(2, 0),
                        child: Container(
                          width: 46.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.teal),
                          child: Card(
                            color: Colors.black,
                            surfaceTintColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  currentQuote,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Utilities()
                                          .appColors(context)
                                          .secondary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(-2, 0),
                        child: Container(
                          width: 46.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.teal,
                          ),
                          child: Card(
                            color: Colors.black,
                            surfaceTintColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    radius: 32,
                                    backgroundColor: Colors.white,
                                    child: Text(
                                      day,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Text(
                                    "$month, $year ",
                                    style: TextStyle(
                                        color: Utilities()
                                            .appColors(context)
                                            .secondary,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    // "Current Time: $time ${int.parse(time.split(':')[0]) < 12 ? "A.M" : "P.M"}",
                                    "Current Time: $time ",
                                    style: TextStyle(
                                        color: Utilities()
                                            .appColors(context)
                                            .secondary,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              ComponentSlideIns(
                beginOffset: Offset(-2, 0),
                child: Container(
                  width: 96.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  height: 32.h,
                  child: Card(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "See User Stats",
                            style: TextStyle(fontSize: 18.sp, color: rootcolor),
                          ),
                          Divider(
                            color: rootcolor,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 45.w,
                                    height: 24.h,
                                    child: ListView.builder(
                                        itemCount: engagementData.length,
                                        itemBuilder: (context, index) {
                                          // final entry = engagementData[index];
                                          // engagementData[index]: This retrieves the map at the specified index in the engagementData list.
                                          // final key = entry.keys.first;
                                          // entry.keys.first: This retrieves the first key of the map stored in the variable entry.
                                          // final value = entry[key];
                                          // entry[key]: This retrieves the value corresponding to the key key in the map stored in the variable entry.
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (engagementData[index]
                                                              ["route"] ==
                                                          "" ||
                                                      engagementData[index]
                                                              ["route"] ==
                                                          null) {
                                                    return;
                                                  } else {
                                                    Navigator.pushNamed(
                                                        context,
                                                        engagementData[index]
                                                            ["route"]);
                                                  }
                                                },
                                                child: ListTile(
                                                  leading: Icon(
                                                    engagementData[index]
                                                        ["icon"],
                                                    // size: 12,
                                                    color: engagementData[index]
                                                        ["bg"],
                                                  ),
                                                  title: Text(
                                                    engagementData[index]
                                                        ["title"],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  subtitle: Text(
                                                      engagementData[index]
                                                              ["number"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              172,
                                                              255,
                                                              255,
                                                              255))),
                                                ),
                                              ),
                                              if (index !=
                                                  engagementData.length - 1)
                                                Divider(
                                                  height: 6,
                                                )
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                      sections: engagementData.map((entry) {
                                        return PieChartSectionData(
                                          color: entry["bg"],
                                          // value: entry["number"].toDouble(),
                                          badgeWidget: Icon(
                                            entry["icon"],
                                            size: 26,
                                            color: Colors.black,
                                          ),
                                          radius: 80,
                                        );
                                      }).toList(),
                                      sectionsSpace: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              ComponentSlideIns(
                beginOffset: Offset(0, 2),
                child: Container(
                  width: 96.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.teal,
                  ),
                  height: 22.h,
                  child: Card(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Manage Continent DB Table",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.sp),
                          ),
                          const Divider(
                            color: Colors.teal,
                          ),
                          Expanded(
                              child: GridView.builder(
                                  itemCount: operations.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 0,
                                          crossAxisSpacing: 50,
                                          childAspectRatio: 5 / 2),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (operations[index]["route"] == "" ||
                                            operations[index]["route"] ==
                                                null) {
                                          return;
                                        } else {
                                          Navigator.pushNamed(context,
                                              operations[index]["route"]);
                                        }
                                      },
                                      child: ListTile(
                                        selectedColor: Colors.amberAccent,
                                        leading: const Icon(
                                          Icons.circle,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                        title: Text(
                                          "${operations[index]["op"]} Continent",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  }))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
