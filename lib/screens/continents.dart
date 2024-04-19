import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Continents extends StatefulWidget {
  const Continents({super.key});

  @override
  State<Continents> createState() => _ContinentsState();
}

class _ContinentsState extends State<Continents> {
  List continents = [
    {
      "title": "Africa",
      "base-img": "africa.jpeg",
      "slideshows": {
        "img1": "africa1.jpg",
        "img2": "africa2.jpg",
        "img3": "africa3.jpg",
        "img4": "africa4.jpg",
      },
      "tags": [
        {
          "facts": {
            "Continent Size": "Second largest in the world",
            "Area": "11,700,000 square miles",
            "Estimated population": "877 million people",
            "Largest City": "Cairo, Egypt, 9.2 million people",
            "Largest Country":
                "Algeria - 919,595 square miles (was Sudan, 968,000 square miles)",
            "Longest River": "Nile, 4,160 miles",
            "Largest Lake": "Victoria, 26,828 square miles",
            "Tallest Mountain": "Kilimanjaro, Tanzania, 19,340 feet"
          },
        },
        {
          "lines": [
            "Discover the Heartbeat of the Wild.",
            "Where Adventure Awaits in Every Corner.",
            "Experience the Richness of Culture and Diversity"
          ]
        }
      ]
    },
    {
      "title": "South America",
      "base-img": "south-america.jpeg",
      "slideshows": {},
    },
    {
      "title": "Asia",
      "base-img": "asia.jpeg",
      "slideshows": {},
    },
    {
      "title": "North America",
      "base-img": "north-america.jpeg",
      "slideshows": {},
    },
    {
      "title": "Australia",
      "base-img": "australia.jpeg",
      "slideshows": {},
    },
    {
      "title": "Europe",
      "base-img": "europe.jpeg",
      "slideshows": {},
    },
    {
      "title": "Antarctica",
      "base-img": "antarctica.jpeg",
      "slideshows": {},
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar().welcomebar(context, "Select a Continent to Explore"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 0,
            ),
            itemCount: continents.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "locations", arguments: {
                    "place": continents[index]["title"],
                    "images": continents[index]["slideshows"],
                    "tags": continents[index]["tags"]
                  });
                },
                child: Card(
                  surfaceTintColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(34)),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            "lib/assets/images/continents/${continents[index]["base-img"]}",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        continents[index]["title"],
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
