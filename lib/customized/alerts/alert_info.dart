// import 'package:reality_shift/imports.dart';
import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class AlertInfo {
  String? title;
  String? message;

  AlertInfo();

  showAlertDialog(BuildContext context, {VoidCallback? func, String? name}) {
    Color secondary = Utilities().appColors(context).secondary;
    // set up the button
    Widget okButton = ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black)),
      child: Text(
        name ?? "OK",
        style: TextStyle(fontWeight: FontWeight.bold, color: secondary),
      ),
      onPressed: () {
        if (func != null) {
          func();
        }
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      surfaceTintColor: Colors.transparent,
      title: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: secondary),
      ),
      insetPadding: const EdgeInsets.all(0),
      content: Text(
        message ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(color: secondary),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
