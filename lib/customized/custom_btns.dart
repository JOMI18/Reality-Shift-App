import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

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

  Widget continentBtn(context, title, func) {
    Color unchanged = const Color.fromARGB(255, 15, 34, 45);

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          fixedSize: const Size(190, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: func,
        child: Text(
          "$title",
          style: TextStyle(color: unchanged),
        ));
  }

  Widget shortBtn(context, title, func) {
    Color unchanged = const Color.fromARGB(255, 15, 34, 45);

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          fixedSize: const Size(180, 50),
          disabledBackgroundColor: Colors.white.withOpacity(0.4),
          disabledForegroundColor: unchanged,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: func,
        child: Text(
          "$title",
          style: TextStyle(color: unchanged),
        ));
  }

  Widget continentImgBtn(context, func) {
    Color unchanged = const Color.fromARGB(255, 15, 34, 45);

    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          foregroundColor: unchanged,
          fixedSize: const Size(380, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: func,
        icon: Icon(Icons.image),
        label: Text(
          "...Click to Upload Image",
        ));
  }

  Widget OtherBtn(context, title, func) {
    Color unchanged = const Color.fromARGB(255, 15, 34, 45);

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          foregroundColor: unchanged,
          fixedSize: const Size(380, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: func,
        child: Text(
          title,
        ));
  }

  Widget buildButton(
    BuildContext context, {
    required String text,
    required Widget icon,
    required Color backgroundColor,
    Color? surfaceTintColor,
    required VoidCallback onPressed,
    Color? foregroundColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        fixedSize: const Size(420, 60),
        backgroundColor: backgroundColor,
        surfaceTintColor: surfaceTintColor,
        foregroundColor: foregroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 15),
          Text(text, style: TextStyle(fontSize: 17.sp)),
        ],
      ),
    );
  }
}
