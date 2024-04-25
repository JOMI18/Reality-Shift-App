import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';
import 'package:reality_shift/transitions/item_slide_ins.dart';

class CustomErrorScreen {
  CustomErrorScreen();

  static Widget buildErrorWidget() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ComponentSlideIns(
              beginOffset: Offset(0, -2),
              duration: Duration(milliseconds: 1500),
              child: Lottie.asset("lib/assets/images/lottie/error.json")),
          ComponentSlideIns(
            beginOffset: Offset(0, 2),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Failed to load data. This service may be temporarily unavailable. Please check your internet connection.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 17.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
