import 'package:flutter/material.dart';
import 'package:reality_shift/services/utilities.dart';

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
              checkOnboardingStatus(),
            });
  }

  Future<void> checkOnboardingStatus() async {
    String? onboardingStatus =
        await CustomSharedPreference().getString("onboarding_completed");

    print(onboardingStatus);

    if (onboardingStatus == null) {
      // If onboarding status is null, it means onboarding hasn't been completed yet
      Navigator.pushReplacementNamed(context, "onboarding");
    } else {
      Navigator.popAndPushNamed(context, "choose_signup");
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Utilities().appColors(context).primary;

    return Scaffold(
      backgroundColor: primary,
      body: Center(
          child: Column(
        children: [
          Image.asset("lib/assets/images/logos/loading-logo.png"),
          Btns().btn(context, "Clear Onboarding", () {
            CustomSharedPreference().remove("onboarding_completed");
          })
        ],
      )),
    );
  }
}
