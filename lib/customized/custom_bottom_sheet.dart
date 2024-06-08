import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';
import 'package:intl/intl.dart';

class CustomBottomSheet {
  CustomBottomSheet();

  // Using a static method is a common practice because it allows you to access the method directly without
  // needing to instantiate the class. This makes the code cleaner and more concise

  static void showGenderSelection(
    context, {
    Widget? content,
    void Function(String)? onSelect,
  }) {
    Color secondary = Utilities().appColors(context).secondary;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 98.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: secondary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Gender',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 4),
                child: const Divider(
                  height: 12.0,
                  thickness: 8,
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: const Text(
                  'Male',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  onSelect?.call('Male');
                  Navigator.pop(context);
                },
              ),
              const Divider(
                height: 20.0,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('Female',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                onTap: () {
                  onSelect?.call('Female');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void showDatePicker(BuildContext context,
      {required Function(String) onDateSelected}) {
    Color secondary = Utilities().appColors(context).secondary;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 98.w,
          height: 28.h,
          decoration: BoxDecoration(
            color: secondary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: EdgeInsets.all(5.0),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              onDateSelected(DateFormat('MM/dd/yyyy').format(newDateTime));
            },
          ),
        );
      },
    );
  }

  static void showContent(BuildContext context, Widget content, height) {
    showModalBottomSheet(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            width: 98.w,
            height: height ,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
            ),
            padding: EdgeInsets.all(5.0),
            child: content);
      },
    );
  }
}
