import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io'; // for pLATFORM
import 'package:reality_shift/imports.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;

class Utilities {
  Utilities();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  Color bgDark = const Color.fromARGB(255, 5, 36, 32);
  Color bgLight = const Color.fromARGB(255, 61, 72, 72);
  Color bg = const Color.fromARGB(255, 4, 21, 20);
  String baseUrl = "https://freedomsbank.s3.eu-west-3.amazonaws.com/";
  String avatar =
      'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1658786565~exp=1658787165~hmac=9e29fe8fe3aae0e0a7a6c46130c436b88929ee15c57acc0d44ce32be5dd8d066';
  // ignore: prefer_typing_uninitialized_variables
  var devices;
  String? userAgent;
  String? platform;

  getDeviceInfo() async {
    if (kIsWeb) {
      userAgent = html.window.navigator.userAgent;
      platform = html.window.navigator.platform;
      return {'model': userAgent, 'id': platform};
    } else if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      devices = androidInfo;
      return {'model': devices.model, 'id': devices.id};
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
      devices = iosInfo;
      // print(devices.model);
      return {'model': devices.model, 'id': devices.name};
    }
  }

  get devicePlatform => getDeviceInfo();

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Copied to clipboard.',
          style: TextStyle(color: Colors.black),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white,
        duration: Duration(seconds: 5)));
  }

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
