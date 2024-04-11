import 'package:flutter/material.dart';

class Btns {
  ColorScheme? colorScheme;
  Btns();

  Widget btn(context, title, func) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            fixedSize: const Size(350, 60),
            backgroundColor: colorScheme.secondary,
            foregroundColor: Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        onPressed: func,
        child: Text("$title",
            style: const TextStyle(
              letterSpacing: 1.2,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            )));
  }

  Widget trnsBtn(context, title, func) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            fixedSize: const Size(350, 60),
            backgroundColor: colorScheme.secondary,
            foregroundColor: Colors.black,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        onPressed: func,
        child: Text("$title",
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            )));
  }

  Widget textBtn(context, title, func) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            fixedSize: const Size(120, 50),
            foregroundColor: colorScheme.primary,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        onPressed: func,
        child: Text("$title",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            )));
  }
}
