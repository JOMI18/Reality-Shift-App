import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reality_shift/imports.dart';

class Pins extends StatefulWidget {
  const Pins({super.key});

  @override
  State<Pins> createState() => _PinsState();
}

class _PinsState extends State<Pins> {
  List boards = [
    {
      "recent": "4",
      "pins": "12",
      "title": "Culture",
      "img": "culture.webp",
      "route": ""
    },
    {
      "recent": "2",
      "pins": "4",
      "title": "Books",
      "img": "fashion.jpg",
      "route": ""
    },
    {
      "recent": "4",
      "pins": "7",
      "title": "Food",
      "img": "food.jpg",
      "route": ""
    },
    {
      "recent": "4",
      "pins": "62",
      "title": "Movies",
      "img": "favs.jpg",
      "route": ""
    },
    {
      "recent": "4",
      "pins": "142",
      "title": "SkinCare",
      "img": "profile.jpg",
      "route": ""
    },
    {
      "recent": "4",
      "pins": "3",
      "title": "Jewelry",
      "img": "settings.jpg",
      "route": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    Color primary = Utilities().appColors(context).primary;
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Customize My Pins:"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Consumer(builder: (context, ref, _) {
            return Column(
              children: [
                ComponentSlideIns(
                  beginOffset: const Offset(0, -2),
                  child: Column(
                    children: [
                      CustomTextField.input(
                        context,
                        hint: "...search your saved ideas",
                        fieldname: "Search Bar",
                        prefixIcon: Icon(
                          Icons.search,
                          color: secondary,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                ComponentSlideIns(
                  beginOffset: const Offset(-2, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: primary,
                              backgroundColor: secondary,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Row(
                              children: [
                                const Text(
                                  "Add:",
                                ),
                                SizedBox(
                                  width: 0.4.w,
                                ),
                                const Icon(
                                  Icons.add,
                                )
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: primary,
                              backgroundColor: secondary,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Row(
                              children: [
                                const Text(
                                  "Sort:",
                                ),
                                SizedBox(
                                  width: 0.4.w,
                                ),
                                const Icon(
                                  Icons.sort,
                                )
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: primary,
                              backgroundColor: secondary,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Row(
                              children: [
                                const Text(
                                  "Filter:",
                                ),
                                SizedBox(
                                  width: 0.4.w,
                                ),
                                const Icon(
                                  Icons.filter_list_rounded,
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                ComponentSlideIns(
                  beginOffset: const Offset(0, 2),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: boards.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 25,
                              crossAxisSpacing: 5,
                              childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        final img = boards[index]["img"];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 18.h,
                                  width: 45.w,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 2, color: secondary),
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "lib/assets/images/navs/$img",
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 25.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: secondary),
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "lib/assets/images/navs/$img",
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  boards[index]["title"],
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${boards[index]["pins"]} pins",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
