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
    {
      "lottie": "world.json",
      "title": "See the World.",
      "message":
          "Explore breathtaking destinations. Discover hidden gems around the globe. Immerse yourself in diverse cultures."
    },
    {
      "lottie": "calender.json",
      "title": "Create a Bucket List.",
      "message":
          "Capture your dream experiences. Set goals and make them happen. Plan your ultimate adventure"
    },
    {
      "lottie": "memories.json",
      "title": "Experience Life Beyond Now.",
      "message":
          "Step out of your comfort zone. Try new activities and unlock new passions. Embrace spontaneous adventures. Make memories that last a lifetime"
    }
  ];

  Future<void> completeOnboarding() async {
    await CustomSharedPreference().setString("onboarding_completed", "true");
    // print("Onboarding completion flag set successfully.");

    // String? flagValue =
    //     await CustomSharedPreference().getString("onboarding_completed");
    // print("Flag value after setting: $flagValue");
  }

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(
            height: 90.h,
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                final page = pages[index];
                // print(page);
                return Column(
                  children: [
                    ComponentSlideIns(
                      beginOffset: const Offset(0, -2),
                      child: Lottie.asset(
                          "lib/assets/images/lottie/${page["lottie"]!}",
                          height: 55.h,
                          fit: BoxFit.fill),
                    ),
                    ComponentSlideIns(
                      beginOffset: const Offset(2, 0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 50, 12, 8),
                        child: Column(children: [
                          Text(
                            page["title"]!,
                            style: TextStyle(
                                fontSize: 21.sp,
                                fontWeight: FontWeight.w700,
                                color: secondary),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.w, vertical: 8),
                            child: Divider(
                              height: 25,
                              thickness: 6,
                              color: secondary,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 20),
                            child: Text(
                              page["message"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.w500),
                            ),
                          )
                        ]),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          ComponentSlideIns(
            beginOffset: const Offset(0, 2),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      completeOnboarding();

                      Navigator.popAndPushNamed(context, "choose_signup");
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: secondary),
                    ),
                  ),
                  Container(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: pages.length,
                      effect: WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: secondary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Check if the current page index is the last index
                      if (_controller.page == pages.length - 1) {
                        completeOnboarding();

                        // Navigate to a new page
                        Navigator.popAndPushNamed(context, "cta");
                      } else {
                        // Navigate to the next page
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: secondary,
                      foregroundColor: Colors.black,
                      child: const Icon(Icons.arrow_forward_rounded),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
