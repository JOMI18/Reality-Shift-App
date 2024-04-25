import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reality_shift/imports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  int currentIndex = 0;
  final Random random = Random();
  late StreamController quoteController;
  late Stream quoteStream;
  late String currentQuote;

  // final googleMapsUrl = 'https://maps.google.com';
  // launch(googleMapsUrl);

  List img = [
    "sky.jpg",
    "taiwan.jpg",
    "fruits.jpg",
    "house.jpg",
    "bread.jpg",
    "koala.jpg",
    "india.jpg",
    "kebhab.jpg",
    "art.jpg",
    "veggies.jpg",
    "statue.jpg",
    "tree.jpg",
    "temple.jpg",
    "road.jpg",
    "penguin.jpg",
    "street.jpg",
    "ice.jpg",
    "waterfall.jpg"
  ];

  List quote = [
    "Believe you can, and you're halfway there. - Theodore Roosevelt",
    "You are capable of amazing things.",
    "Every day may not be good, but there's something good in every day.",
    "You are enough.",
    "In the midst of difficulty lies opportunity.- Albert Einstein",
    "You are stronger than you think.",
    "Progress, not perfection.",
    "Every accomplishment starts with the decision to try.",
    "Your potential is endless.",
    "Embrace the journey, trust the process.",
    "Difficult roads often lead to beautiful destinations.",
    "You are worthy of love and success.",
    "Keep going, you're on the right track.",
    "The only way to do great work is to love what you do. - Steve Jobs",
    "You have the power to create change.",
    "For I know the plans I have for you, declares the Lord, plans for welfare and not for evil, to give you a future and a hope. - Jeremiah 29:11",
    "I can do all things through him who strengthens me. - Philippians 4:13",
    "Trust in the Lord with all your heart, and do not lean on your own understanding. In all your ways acknowledge him, and he will make straight your paths. - Proverbs 3:5-6",
    "But they who wait for the Lord shall renew their strength; they shall mount up with wings like eagles; they shall run and not be weary; they shall walk and not faint. - Isaiah 40:31",
    "And we know that for those who love God all things work together for good, for those who are called according to his purpose. - Romans 8:28",
    "Fear not, for I am with you; be not dismayed, for I am your God; I will strengthen you, I will help you, I will uphold you with my righteous right hand. - Isaiah 41:10",
    "The Lord is my shepherd; I shall not want. He makes me lie down in green pastures. He leads me beside still waters. He restores my soul. He leads me in paths of righteousness for his name's sake. - Psalm 23:1-3",
    "Commit your work to the Lord, and your plans will be established. - Proverbs 16:3",
    "And let us not grow weary of doing good, for in due season we will reap, if we do not give up.  - Galatians 6:9",
    "Peace I leave with you; my peace I give to you. Not as the world gives do I give to you. Let not your hearts be troubled, neither let them be afraid. - John 14:27"
  ];

  List navs = [
    {"bg": Colors.pink, "title": "Culture", "img": "taiwan.jpg", "route": ""},
    {"bg": Colors.teal, "title": "Fashion", "img": "ice.jpg", "route": ""},
    {"bg": Colors.teal, "title": "Fashion", "img": "ice.jpg", "route": ""},
    {"bg": Colors.pink, "title": "Culture", "img": "taiwan.jpg", "route": ""},
  ];

  String _getRandomQuote() {
    // var intValue = Random().nextInt(10); // Value is >= 0 and < 10.
    return quote[random.nextInt(quote.length)];
  }

  void _startAutoScroll() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (currentIndex < img.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void startTimer() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      final newQuote = _getRandomQuote();

      quoteController.add(newQuote);
      setState(() {
        currentQuote = newQuote;
      });
    });
  }

  // final Uri uri = Uri.parse('https://www.xe.com/');
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoScroll();

    currentQuote = _getRandomQuote();
    quoteController = StreamController.broadcast();
    quoteStream = quoteController.stream;

    startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color rootcolor = Utilities().appColors(context).secondary;
    // Color newcolor = Utilities().appColors(context).primary;

    return Scaffold(
      appBar: CustomAppBar()
          .dashboardbar(context, "Hi, Oluwajomiloju", "germany.png"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              ComponentSlideIns(
                beginOffset: const Offset(-2, 0),
                child: Column(
                  children: [
                    CustomTextField.input(
                      context,
                      hint: "What would you like to explore",
                      fieldname: "Search Bar",
                      prefixIcon: Icon(
                        Icons.search,
                        color: rootcolor,
                      ),
                      // color: rootcolor,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              ComponentSlideIns(
                beginOffset: const Offset(2, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Icon(
                          Icons.pin_drop_rounded,
                          color: rootcolor,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Scenic Serenity: Discover the World",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: rootcolor, fontSize: 17.sp),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 35.h,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: img.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 30.h,
                            width: 94.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 2, color: rootcolor),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "lib/assets/images/cards/${img[index]}"),
                                    fit: BoxFit.cover)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              ComponentSlideIns(
                beginOffset: const Offset(-2, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: rootcolor,
                            size: 22,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                              "Inspiration for Every Step: Words to Lift Your Spirit",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: rootcolor, fontSize: 16.sp))
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: rootcolor),
                          borderRadius: BorderRadius.circular(17)),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              currentQuote,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              // navigation to diff parts
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.travel_explore_rounded,
                          color: rootcolor,
                          size: 22,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text("Explore Boundless Horizons: Begin Your Adventure",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: rootcolor, fontSize: 16.sp))
                      ],
                    ),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: navs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 1.5),
                      itemBuilder: (context, index) {
                        final img = navs[index]["img"];
                        return ClipRect(
                          clipBehavior: Clip.antiAlias, // Set the clip behavior

                          child: Container(
                            height: 4.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                color: navs[index]["bg"],
                                border: Border.all(width: 2, color: rootcolor),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  navs[index]["title"],
                                  textAlign: TextAlign.center,
                                ),
                                Transform.rotate(
                                  angle: 0.8,
                                  origin: const Offset(34, 80),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(60)),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: AssetImage(
                                        "lib/assets/images/cards/$img",
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),

              // services, to book flights, calculate currency, map
              SizedBox(
                height: 2.h,
              ),
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        _launchURL(
                            'https://www.xe.com/'); // Launch URL when tapped
                      },
                      child: const Text("Currency Converter"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
