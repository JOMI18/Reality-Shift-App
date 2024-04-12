import 'package:flutter/material.dart';

class Utilities {
  Utilities();

  ColorScheme appColors(context) {
    return Theme.of(context).colorScheme;
  }

  String hidePhoneNumber(String number) {
    // check validity of number --> at least 6 numbers
    if (number.length < 6) {
      return number;
    }
    // hide number from 3 to 8
    return number.replaceRange(3, 6, "*");
  }

  String hideEmailAddress(String email) {
    // check validity of email --? contains an @
    if (!email.contains("@")) {
      return email;
    }
    // split to hide
    List<String> parts = email.split("@");
    String user = parts[0];
    String domain = parts[1];

    if (user.length < 4) {
      return email;
    }
    // mask
    String masked = user[0] + "*" * (user.length - 2) + user[user.length - 1];
    return "$masked@$domain";
  }
}
