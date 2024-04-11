import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();

  final List pages = [
    [
      {
        "lottie": "world.json",
        "title": "See the World.",
        "message":
            "Explore breathtaking destinations. Discover hidden gems around the globe. Immerse yourself in diverse cultures."
      }
    ],
    [
      {
        "lottie": "calender.json",
        "title": "Create a Bucket List.",
        "message":
            "Capture your dream experiences. Set goals and make them happen. Plan your ultimate adventure"
      }
    ],
    [
      {
        "lottie": "memories.json",
        "title": "Experience Life Beyond Now.",
        "message":
            "Step out of your comfort zone. Try new activities and unlock new passions. Embrace spontaneous adventures. Make memories that last a lifetime"
      }
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 90.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return Column(
                  children: pages[index].map<Widget>(
                (page) {
                  return Column(
                    children: [
                      ComponentSlideIns(
                        beginOffset: Offset(0, -2),
                        child: Lottie.asset(
                            "lib/assets/images/lottie/${page["lottie"]!}",
                            height: 52.h,
                            fit: BoxFit.fill),
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(2, 0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
                          child: Column(children: [
                            Text(
                              page["title"]!,
                              style: TextStyle(
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      Utilities().appColors(context).primary),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.w, vertical: 8),
                              child: Divider(
                                height: 25,
                                thickness: 6,
                                color: Utilities().appColors(context).secondary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 20),
                              child: Text(
                                page["message"]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                        ),
                      )
                    ],
                  );
                },
              ).toList());
            },
          ),
        ),
        ComponentSlideIns(
          beginOffset: Offset(0, 2),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "signup");
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Utilities().appColors(context).secondary),
                  ),
                ),
                Container(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: pages.length,
                    effect: WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Utilities().appColors(context).secondary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Check if the current page index is the last index
                    if (_controller.page == pages.length - 1) {
                      // Navigate to a new page
                      Navigator.pushNamed(context, "cta");
                    } else {
                      // Navigate to the next page
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Utilities().appColors(context).secondary,
                    foregroundColor: Colors.black,
                    child: Icon(Icons.arrow_forward_rounded),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
