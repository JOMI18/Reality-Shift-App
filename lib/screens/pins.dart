import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Pins extends StatefulWidget {
  const Pins({super.key});

  @override
  State<Pins> createState() => _PinsState();
}

class _PinsState extends State<Pins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Customize My Favorite Pins:"),
    );
  }
}
