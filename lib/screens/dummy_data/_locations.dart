import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reality_shift/imports.dart';

class _Locations extends StatefulWidget {
  const _Locations({super.key});

  @override
  State<_Locations> createState() => __LocationsState();
}

class __LocationsState extends State<_Locations> {
  final PageController _controller = PageController();

  List countries = [
    {"title": "Egypt", "img": "africa/egypt.png"},
    {"title": "Nigeria", "img": "africa/nigeria.png"},
    {"title": "U.S.A", "img": "usa.png"},
    {"title": "U.K", "img": "uk.png"},
    {"title": "Egypt", "img": "africa/egypt.png"},
    {"title": "Nigeria", "img": "africa/nigeria.png"},
    {"title": "U.S.A", "img": "usa.png"},
    {"title": "U.K", "img": "uk.png"},
    {"title": "Egypt", "img": "africa/egypt.png"},
    {"title": "Nigeria", "img": "africa/nigeria.png"},
    {"title": "U.S.A", "img": "usa.png"},
    {"title": "U.K", "img": "uk.png"},
    {"title": "Egypt", "img": "africa/egypt.png"},
    {"title": "Nigeria", "img": "africa/nigeria.png"},
    {"title": "U.S.A", "img": "usa.png"},
    {"title": "U.K", "img": "uk.png"},
    {"title": "Egypt", "img": "africa/egypt.png"},
    {"title": "Nigeria", "img": "africa/nigeria.png"},
    {"title": "U.S.A", "img": "usa.png"},
    {"title": "U.K", "img": "uk.png"},
    {"title": "Egypt", "img": "africa/egypt.png"},
    {"title": "Nigeria", "img": "africa/nigeria.png"},
    {"title": "U.S.A", "img": "usa.png"},
    {"title": "U.K", "img": "uk.png"},
    {"title": "Egypt", "img": "africa/egypt.png"},
  ];

  late Map continent;
  late Map<String, dynamic> facts;
  late List<String> lines;
  late Map images;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();

    continent = ModalRoute.of(context)!.settings.arguments as Map;
    print(continent);

    List tags = continent['tags'];
    // print("tags: ------ $tags");

    facts = tags[0]['facts'];
    // print("facts: ------ $facts");

    lines = tags[1]['lines'];
    // print("lines: ------ $lines");

    images = continent['images'];

    // print("images: ------ $images");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar()
          .welcomebar(context, "Countries in ${continent["place"]}:"),
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
                      color: Utilities().appColors(context).secondary,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 5, color: Colors.white)),
                  child: Column(
                    children: [
                      Container(
                        width: 100.w,
                        height: 28.h,
                        child: PageView.builder(
                            controller: _controller,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              final key = images.keys.elementAt(index);
                              final factValue = images[key];
                              return Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "lib/assets/images/countries/africa/slides/${factValue}",
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
                                backgroundColor:
                                    Utilities().appColors(context).primary,
                                foregroundColor:
                                    Utilities().appColors(context).secondary,
                                child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  size: 14,
                                ),
                              ),
                            ),
                            Container(
                              child: SmoothPageIndicator(
                                controller: _controller,
                                count: images.length,
                                effect: WormEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  activeDotColor:
                                      Utilities().appColors(context).primary,
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
                                backgroundColor:
                                    Utilities().appColors(context).primary,
                                foregroundColor:
                                    Utilities().appColors(context).secondary,
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
                                "lib/assets/images/countries/${countries[index]["img"]}",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            countries[index]["title"],
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
