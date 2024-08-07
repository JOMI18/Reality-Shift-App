import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String api = "http://10.0.2.2:8000";

//////////////////// SEARCH FUNCTIONALITY ////////////////////////
  TextEditingController searchController = TextEditingController();
  bool isSearchActivated = false;
  Timer? debounceTimer;
  List<String> searchSuggestions = [
    // prettier-ignore
    'Food', "Pizza", "Africa", 'Culture', "Fashion", "Asia", "Tech", "America",
  ];
  List<String> searchResults = [];

  // Define a map for query-to-route mapping
  final Map<String, String> queryRouteMap = {
    'Paris': 'user',
    'Food': 'favs',
    // Add more query-to-route mappings as needed
  };

  void onQueryChanged(String query) {
    // Added a Timer for debouncing the input to reduce the number of state updates. This is particularly useful for better performance in scenarios where the user types quickly.
    debounceTimer?.cancel();
    debounceTimer = Timer(Duration(milliseconds: 300), () {
      setState(() {
        searchResults = searchSuggestions
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
        // print(searchResults);
      });

      if (query.isEmpty) {
        searchResults = [];
      }
    });
  }

  void onQuerySubmitted(String query) {
    setState(() {
      if (query.isNotEmpty && !searchSuggestions.contains(query)) {
        searchSuggestions.add(query);
        print(searchSuggestions);
      }

      searchResults = searchSuggestions
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();

      searchController.clear();
    });

    // Print the query and the keys of the map for debugging
    // print('Submitted query: $query');
    // print('Query in lowercase: ${query.toLowerCase()}');
    // print('Available routes: ${queryRouteMap.keys.toList()}');

    // final routeName = queryRouteMap[query.toLowerCase()];
    // print(routeName);
    // if (routeName != null) {
    //   Navigator.pushNamed(context, routeName);
    // } else {
    //   print('No route found for query: $query');
    // }
  }

//////////////////// CAROUSEL FUNCTIONALITY ////////////////////////
  late PageController page_controller;
  int currentIndex = 0;
  Timer? imageTimer;

  List img = [
    // prettier-ignore
    "sky.jpg", "taiwan.jpg", "fruits.jpg", "house.jpg", "bread.jpg",
    "koala.jpg", "tree.jpg", "waterfall.jpg",
    "india.jpg", "kebhab.jpg", "art.jpg", "veggies.jpg", "statue.jpg",
    "temple.jpg", "road.jpg", "penguin.jpg", "street.jpg", "ice.jpg",
  ];

  void _startAutoScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This change ensures that the _startAutoScroll method is called only after the first frame has been rendered, and it also checks if the PageController has clients (i.e., is attached to any scroll views) before trying to animate to a page.
      imageTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
        if (page_controller.hasClients) {
          if (currentIndex < img.length - 1) {
            currentIndex++;
          } else {
            currentIndex = 0;
            page_controller.jumpToPage(0); // Jump to the first page
          }
          page_controller.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      });
    });
  }

//////////////////// QUOTE FUNCTIONALITY ////////////////////////
  late StreamController quoteController;
  late Stream quoteStream;
  final Random random = Random();
  late String currentQuote;
  Timer? quoteTimer;

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

  String _getRandomQuote() {
    // var intValue = Random().nextInt(10); // Value is >= 0 and < 10.
    return quote[random.nextInt(quote.length)];
  }

  void startTimer() {
    quoteTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (!quoteController.isClosed) {
        // Check if the controller is not closed
        final newQuote = _getRandomQuote();
        quoteController.add(newQuote); // Add new quote to the stream
        setState(() {
          currentQuote = newQuote;
        });
      }
    });
  }

//////////////////// NAVIGATION FUNCTIONALITY ////////////////////////
  List navs = [
    {"bg": Colors.pink, "title": "Culture", "img": "culture.webp", "route": ""},
    {"bg": Colors.teal, "title": "Fashion", "img": "fashion.jpg", "route": ""},
    {"bg": Colors.purple, "title": "Food", "img": "food.jpg", "route": ""},
    {"bg": Colors.blue, "title": "Favs", "img": "favs.jpg", "route": "favs"},
    {
      "bg": Colors.teal,
      "title": "Profile",
      "img": "profile.jpg",
      "route": "full_user_profile"
    },
    {
      "bg": Colors.deepOrange,
      "title": "Settings",
      "img": "settings.jpg",
      "route": "user"
    },
    {
      "bg": Colors.amber,
      "title": "To-do",
      "img": "tips.jpg",
      "route": "bucket_list"
    },
    {"bg": Colors.pink, "title": "Nature", "img": "nature.jpg", "route": ""},
  ];

//////////////////// SERVICE FUNCTIONALITY ////////////////////////
  List service = [
    {
      "bg": Colors.green,
      "icon": Icons.currency_exchange_rounded,
      "title": "Currency Converter",
      "subtext": "Travel smart with accurate exchange rates",
      "url": "https://www.xe.com/"
    },
    {
      "bg": Colors.blue,
      "icon": Icons.map_rounded,
      "title": "Google Maps",
      "subtext": "Navigate the world effortlessly",
      "url": "https://www.google.com/maps/"
    },
    {
      "bg": Colors.amber,
      "icon": Icons.airplane_ticket_rounded,
      "title": "Airways",
      "subtext": "Book flights hassle-free",
      "url": "https://www.wakanow.com/"
    },
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    page_controller = PageController(initialPage: 0);

    currentQuote = _getRandomQuote();
    quoteController = StreamController.broadcast();
    quoteStream = quoteController.stream;

    // Wait for the first frame to be rendered before calling _startAutoScroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    page_controller.dispose();
    quoteController.close();
    quoteTimer?.cancel();
    imageTimer?.cancel();
    debounceTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    Color primary = Utilities().appColors(context).primary;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer(builder: (context, ref, _) {
        final user = ref.watch(userProvider.notifier).state;
        final username = user.firstname;

        final selectedTheme = ref.watch(AppThemeProvider)["theme"];
        Color colorbgWhite = selectedTheme == darkTheme ? primary : secondary;

        return Scaffold(
          appBar: CustomAppBar().dashboardbar(context, "Hi, $username"),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _buildSearchBar(context, secondary),
                    SizedBox(
                      height: 2.h,
                    ),
                    isSearchActivated
                        ? _buildSearchScreen(
                            secondary,
                          )
                        : Column(
                            children: [
                              _buildImageCarousel(secondary),
                              SizedBox(
                                height: 2.h,
                              ),
                              _buildQuoteCard(secondary, colorbgWhite),
                              SizedBox(
                                height: 2.h,
                              ),
                              _buildNavigationGrid(
                                secondary,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              _buildServiceList(secondary)
                            ],
                          )
                  ],
                )),
          ),
        );
      }),
    );
  }

  Widget _buildSearchBar(context, secondary) {
    return ComponentSlideIns(
      beginOffset: const Offset(-2, 0),
      child: Column(
        children: [
          CustomTextField.input(
            onTap: () {
              setState(() {
                isSearchActivated = true;
              });
            },
            onChanged: onQueryChanged,
            onFieldSubmitted: onQuerySubmitted,
            controller: searchController,
            context,
            hint: "What would you like to explore",
            fieldname: "Search Bar",
            prefixIcon: Icon(
              Icons.search,
              color: secondary,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchScreen(
    secondary,
  ) {
    return SizedBox(
      height: 80.h,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isSearchActivated = false;
                  searchResults = [];
                  FocusScope.of(context).unfocus();
                  // print(isSearchActivated);
                });
              },
              child: ListTile(
                trailing: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                title: Text(
                  "Cancel Search".toUpperCase(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Divider(
                color: Colors.red,
                thickness: 6,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        final selectedQuery = searchResults[index];

                        final routeName =
                            queryRouteMap[selectedQuery.toLowerCase()];

                        if (routeName != null) {
                          Navigator.pushNamed(context, routeName);
                        } else {
                          // Handle the case where the query does not match any route
                          print('No route found for query:');
                        }
                      },
                      child: Text(
                        searchResults[index],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel(secondary) {
    return ComponentSlideIns(
      beginOffset: const Offset(2, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Icon(
                Icons.pin_drop_rounded,
                color: secondary,
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                "Scenic Serenity: Discover the World",
                textAlign: TextAlign.center,
                style: TextStyle(color: secondary, fontSize: 17.sp),
              ),
            ]),
          ),
          SizedBox(
            height: 35.h,
            child: PageView.builder(
              controller: page_controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              scrollDirection: Axis.horizontal,
              itemCount: img.length,
              itemBuilder: (context, index) {
                final image = "lib/assets/images/cards/${img[index]}";
                return Container(
                  height: 30.h,
                  width: 94.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: secondary),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(secondary, colorbgWhite) {
    return ComponentSlideIns(
      beginOffset: const Offset(-2, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.sunny,
                  color: secondary,
                  size: 22,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text("Inspiration for Every Step: Words to Lift Your Spirit",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: secondary, fontSize: 16.sp))
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: secondary),
                borderRadius: BorderRadius.circular(19)),
            child: Card(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              //   side: BorderSide(width: 2, color: secondary),
              // ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    currentQuote,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorbgWhite,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationGrid(secondary) {
    return ComponentSlideIns(
      beginOffset: const Offset(2, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.travel_explore_rounded,
                  color: secondary,
                  size: 22,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text("Explore Boundless Horizons: Begin Your Adventure",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: secondary, fontSize: 16.sp))
              ],
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              itemCount: navs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.5),
              itemBuilder: (context, index) {
                final img = "lib/assets/images/navs/${navs[index]["img"]}";
                final route = navs[index]["route"];
                final bg = navs[index]["bg"];
                final title = navs[index]["title"];

                return ClipRect(
                  clipBehavior: Clip.antiAlias, // Set the clip behavior

                  child: GestureDetector(
                    onTap: () {
                      if (route == "") {
                        return;
                      }
                      Navigator.pushNamed(context, route);
                    },
                    child: Container(
                      height: 4.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: bg,
                          border: Border.all(width: 2, color: secondary),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                          ),
                          Transform.rotate(
                            angle: 0.8,
                            origin: const Offset(34, 80),
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: secondary),
                                  borderRadius: BorderRadius.circular(60)),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                  img,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget _buildServiceList(secondary) {
    return ComponentSlideIns(
      beginOffset: const Offset(-2, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.travel_explore_rounded,
                  color: secondary,
                  size: 22,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text("Endless Services: Your Passport to Convenience",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: secondary, fontSize: 16.sp))
              ],
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: service.length,
            itemBuilder: (context, index) {
              final link = service[index]["url"];
              final icon = service[index]["icon"];
              final bg = service[index]["bg"];
              final title = service[index]["title"];
              final subtext = service[index]["subtext"];
              return GestureDetector(
                onTap: () {
                  _launchURL(link); // Launch URL when tapped
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(
                      icon,
                      color: bg,
                    ),
                    title: Text(title),
                    subtitle: Text(subtext),
                    trailing: const Icon(
                      Icons.open_in_browser_rounded,
                      color: Color.fromARGB(255, 0, 88, 3),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
