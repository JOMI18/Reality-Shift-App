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
  late List slideshows;
  late List facts;
  late List lines;
  late List countries;
  late String title;

  String api = "http://10.0.2.2:8000";
  // String api = "http://realityshift.com";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();

    Map continent = ModalRoute.of(context)!.settings.arguments as Map;
    // print(continent);

    details = continent["details"];
    // print(details);

    slideshows = jsonDecode(details["slideshows"]);
    // // i need to decode it because i encoded it like a string
    // // print(slideshows.runtimeType); // to determine type
    // print(slideshows);

    List tags = jsonDecode(details['tags']);
    // print(tags);

    title = details['title'];
    // print(title);

    facts = tags[0]["fact"];

    // print(facts);

    lines = tags[1]['tagline'];
    // print(lines);

    countries = jsonDecode(details["countries"]);
    // print(countries);
  }

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    Color primary = Utilities().appColors(context).primary;

    return Scaffold(
      appBar: CustomAppBar()
          .generalbar(context, "Countries in ${details["title"]}:"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildFacts(),
              SizedBox(
                height: 2.h,
              ),
              _buildCarousel(secondary, primary),
              SizedBox(
                height: 3.5.h,
              ),
              _buildCountry(primary, secondary),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFacts() {
    return Container(
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
                  final key = facts[index]["key"];
                  final value = facts[index]["value"];
                  print(key);
                  // final factValue = facts[factKey];
                  return Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$key: $value",
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
    );
  }

  Widget _buildCarousel(secondary, primary) {
    return Container(
      decoration: BoxDecoration(
          color: secondary,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 5, color: Colors.white)),
      child: Column(
        children: [
          SizedBox(
            width: 100.w,
            height: 28.h,
            child: PageView.builder(
                controller: _controller,
                itemCount: slideshows.length,
                itemBuilder: (context, index) {
                  final factValue = slideshows[index];
                  return Container(
                      width: 100.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                      child: CachedNetworkImage(
                        imageUrl:
                            "$api/Continents/$title/Slideshows/$factValue",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ));
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
                    backgroundColor: primary,
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 14,
                      color: secondary,
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
                      activeDotColor: primary,
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
                    backgroundColor: primary,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: secondary,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
              child: ListView.builder(
                itemCount: lines.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(
                        " --- ${lines[index]["value"]}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                      ),
                      if (index != lines.length - 1)
                        const SizedBox(
                          height: 20,
                        )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCountry(primary, secondary) {
    return SizedBox(
      height: 60.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Countries:",
                style: TextStyle(fontSize: 22),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: primary,
                      backgroundColor: secondary,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 5),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index]["country"];
                  final flag = countries[index]["flag"];
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
                            backgroundImage: NetworkImage(
                              "$api/Continents/$title/Flags/$flag",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          country,
                          textAlign: TextAlign.center,
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
    );
  }
}
