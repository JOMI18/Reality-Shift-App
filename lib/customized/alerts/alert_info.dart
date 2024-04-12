// import 'package:reality_shift/imports.dart';
import 'package:flutter/material.dart';

class AlertInfo {
  String? title;
  String? message;

  AlertInfo();

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text(
        "OK",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      surfaceTintColor: Colors.transparent,
      title: Text(
        title ?? '',
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      insetPadding: const EdgeInsets.all(0),
      content: Text(
        message ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
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
