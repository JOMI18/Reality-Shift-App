import 'package:flutter/material.dart';
// import 'package:reality_shift/imports.dart';

class AlertLoading {
  String? title = "please wait.....";
  String? message = 'Loading....';

  AlertLoading();

  showAlertDialog(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(vertical: 10),
      content: SizedBox(
          height: 100,
          width: 320,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  strokeWidth: 5.0,
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(message ?? '')
              ],
            ),
          )),
      actions: const [
        // okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(child: alert, onWillPop: () => Future.value(false));
      },
    );
  }

  closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
