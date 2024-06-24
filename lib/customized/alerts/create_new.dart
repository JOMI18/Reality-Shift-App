import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class CreateNew {
  CreateNew();

  static Future<String?> showFolderDialog(BuildContext context,
      {String? name,
      String? hint,
      TextEditingController? inputCt,
      VoidCallback? onpressed,
      String? second_action,
      String? first_action,
      VoidCallback? option}) async {
    Color rootcolor = Utilities().appColors(context).secondary;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          title: Text(
            name ?? "",
            style: TextStyle(color: rootcolor),
          ),
          content: TextField(
            controller: inputCt,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: rootcolor.withOpacity(0.7)),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: rootcolor),
              ),
            ),
            ElevatedButton(
              onPressed: onpressed,
              child: Text(first_action ?? ""),
            ),
            TextButton(
              onPressed: option,
              child: Text(
                second_action ?? "",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
