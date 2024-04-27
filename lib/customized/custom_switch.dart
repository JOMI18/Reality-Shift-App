import 'package:flutter/material.dart';

class CustomSwitch {
  CustomSwitch();

  static Widget buildSwitch(context,
      {required bool isSwitchOn, required ValueChanged<bool> onChanged}) {
    // bool isSwitchOn = false;
    Color newcolor = Colors.white;
    Color unchanged = const Color.fromARGB(255, 15, 34, 45);
    return Switch(
      activeColor: unchanged,
      inactiveThumbColor: newcolor,
      activeTrackColor: newcolor,
      inactiveTrackColor: unchanged,
      value: isSwitchOn,
      onChanged: onChanged,
    );
  }
}
