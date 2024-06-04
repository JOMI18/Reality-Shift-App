import 'package:flutter/material.dart';

import 'package:reality_shift/imports.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
        const Duration(milliseconds: 3000),
        () => {
              determineInitialScreen(),
            });
  }

  Future<void> determineInitialScreen() async {
    String? onboardingStatus =
        await CustomSharedPreference().getString("onboarding_completed");
    // print(onboardingStatus);

    String? registeredUserStatus =
        await CustomSharedPreference().getString("token");
    // print(registeredUserStatus);

    if (onboardingStatus == null) {
      // If onboarding status is null, it means onboarding hasn't been completed yet
      Navigator.pushReplacementNamed(context, "onboarding");
    }
    if (onboardingStatus != null && registeredUserStatus == null) {
      Navigator.popAndPushNamed(context, "choose_signup");
    }
    if (onboardingStatus == "true" && registeredUserStatus != null) {
      Navigator.pushReplacementNamed(context, "login");
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Utilities().appColors(context).primary;

    return Scaffold(
      backgroundColor: primary,
      floatingActionButton: FloatingActionButton(
          child: const Text(
            "Clear ONB",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            CustomSharedPreference().remove("onboarding_completed");
          }),
      body: Center(
          child: Image.asset("lib/assets/images/logos/loading-logo.png")),
    );
  }
}
