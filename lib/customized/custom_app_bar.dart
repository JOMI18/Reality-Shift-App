import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class CustomAppBar {
  CustomAppBar();

  PreferredSizeWidget welcomebar(context, title) {
    return AppBar(
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: Divider(
          height: 12,
          thickness: 12,
          color: Colors.white,
        ),
      ),
      automaticallyImplyLeading: false,
      foregroundColor: Utilities().appColors(context).secondary,
      title: Row(
        children: [
          Image.asset(
            "lib/assets/images/logo-icon.png",
            height: 5.h,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "$title",
            style: TextStyle(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
