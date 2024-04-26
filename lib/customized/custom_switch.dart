import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class CustomSwitch {
  CustomSwitch();

  static Widget buildSwitch(context,
      {required bool isSwitchOn, required ValueChanged<bool> onChanged}) {
    // bool isSwitchOn = false;
    Color newcolor = Colors.white;
    Color rootcolor = Utilities().appColors(context).primary;
    return Switch(
      activeColor: rootcolor,
      inactiveThumbColor: newcolor,
      activeTrackColor: newcolor,
      inactiveTrackColor: rootcolor,
      value: isSwitchOn,
      onChanged: onChanged,
    );
  }
}
