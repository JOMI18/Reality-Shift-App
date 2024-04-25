import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  final PageController _controller = PageController();

  late Map details;
  late Map slideshows;
  late Map facts;
  late List lines;
  late List countries;
  late String title;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();

    Map continent = ModalRoute.of(context)!.settings.arguments as Map;
    // print(continent);

    details = continent["details"];
    // print(details);

    slideshows = jsonDecode(details["slideshows"]);
    // i need to decode it because i encoded it like a string
    // print(slideshows.runtimeType); // to determine type
    // print(slideshows);

    List tags = jsonDecode(details['tags']);
    // print(tags);

    title = details['title'].toLowerCase();
    print(title);

    facts = tags[0]['facts'];
    // print(facts);

    lines = tags[1]['lines'];
    // print(lines);

    countries = jsonDecode(details["countries"]);
    // print(countries);
  }

  @override
  Widget build(BuildContext context) {
    Color rootcolor = Utilities().appColors(context).secondary;
    Color newcolor = Utilities().appColors(context).primary;

    return Scaffold(
      appBar: CustomAppBar()
          .welcomebar(context, "Countries in ${details["title"]}:"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 12.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Interesting Facts :",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: facts.length,
                            itemBuilder: (context, index) {
                              final factKey = facts.keys.elementAt(index);
                              final factValue = facts[factKey];
                              return Card(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "$factKey: $factValue",
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: rootcolor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 5, color: Colors.white)),
                  child: Column(
                    children: [
                      Container(
                        width: 100.w,
                        height: 28.h,
                        child: PageView.builder(
                            controller: _controller,
                            itemCount: slideshows.length,
                            itemBuilder: (context, index) {
                              final key = slideshows.keys.elementAt(index);
                              final factValue = slideshows[key];
                              return Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          // $africa WILL CHANGE BASED ON SELeCTED
                                          "lib/assets/images/countries/$title/slides/${factValue}",
                                        ),
                                        fit: BoxFit.cover)),
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _controller.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: newcolor,
                                child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  size: 14,
                                ),
                              ),
                            ),
                            Container(
                              child: SmoothPageIndicator(
                                controller: _controller,
                                count: slideshows.length,
                                effect: WormEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  activeDotColor: newcolor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: newcolor,
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
                          child: ListView.builder(
                            itemCount: lines.length,
                            itemBuilder: (context, index) {
                              return Text(
                                lines[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 5),
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    return Card(
                      surfaceTintColor: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(34)),
                            child: CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(
                                "lib/assets/images/countries/$title/${countries[index]["flag"]}",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            countries[index]["country"],
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
