import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';
import 'package:reality_shift/services/utilities.dart';

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

  List<double> data = [25.0, 35.0, 20.0, 10.0, 10.0];
  bool touchedIndex = true;
  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.orange,
  ];
  String _getRandomQuote() {
    return quotes[random.nextInt(quotes.length)];
  }

  @override
  void initState() {
    super.initState();
    currentQuote = _getRandomQuote();
    quoteController = StreamController<String>.broadcast();
    quoteStream = quoteController.stream;

    // Generate a new random quote every 2 minutes
    timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      final newQuote = _getRandomQuote();

      quoteController.add(newQuote);
      setState(() {
        currentQuote = newQuote;
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
    return Scaffold(
      appBar: CustomAppBar().welcomebar(context, "Admin: Control System"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Card(
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
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
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
                                  color:
                                      Utilities().appColors(context).secondary,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.white,
                                child: Text(
                                  "18",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                "January, 2005 ",
                                style: TextStyle(
                                    color: Utilities()
                                        .appColors(context)
                                        .secondary,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Current Time: 4:00 A.M ",
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
                  ],
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: 96.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              height: 32.h,
              child: Card(
                color: Colors.black,
                child: Column(
                  children: [
                    Text(
                      "See User Stats",
                      style: TextStyle(
                          color: Utilities().appColors(context).secondary),
                    ),
                    AspectRatio(
                      aspectRatio: 2,
                      child: PieChart(
                        PieChartData(
                          sections: List.generate(
                            data.length,
                            (index) {
                              final isTouched = index == touchedIndex;
                              final double fontSize = isTouched ? 25 : 16;
                              final double radius = isTouched ? 60 : 50;
                              return PieChartSectionData(
                                color: colors[index],
                                value: data[index],
                                title: '${data[index]}%',
                                radius: radius,
                                titleStyle: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                          sectionsSpace: 0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
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
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
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
                                        operations[index]["route"] == null) {
                                      return;
                                    } else {
                                      Navigator.pushNamed(
                                          context, operations[index]["route"]);
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
          ],
        ),
      ),
    );
  }
}
