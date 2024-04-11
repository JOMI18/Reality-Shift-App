import 'package:flutter/material.dart';
import 'package:reality_shift/services/utilities.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 3000), () => {onboarding()});
  }

  // forms will be created later
  void onboarding() {
    Navigator.pushNamed(context, "onboarding");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utilities().appColors(context).primary,
      body: Center(child: Image.asset("lib/assets/images/loading-logo.png")),
    );
  }
}
