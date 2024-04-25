import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Notify"),
    );
  }
}
