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
      title: ComponentSlideIns(
        beginOffset: Offset(0, -2),
        child: Row(
          children: [
            Image.asset(
              "lib/assets/images/logo-icon.png",
              height: 5.h,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text("$title",
                textAlign: TextAlign.end, style: TextStyle(fontSize: 20.sp)),
          ],
        ),
      ),
    );
  }
}
