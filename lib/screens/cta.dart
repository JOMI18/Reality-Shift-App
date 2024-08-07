import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class CTA extends StatelessWidget {
  const CTA({super.key});

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 70, 0, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ComponentSlideIns(
              beginOffset: Offset(2, 0),
              child: Lottie.asset("lib/assets/images/lottie/convinced.json",
                  height: 50.h, fit: BoxFit.fill),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              child: Column(children: [
                ComponentSlideIns(
                  beginOffset: Offset(-2, 0),
                  child: Text(
                    "Fully convinced?",
                    style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w700,
                        color: secondary),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8),
                  child: Divider(height: 25, thickness: 6, color: secondary),
                ),
                ComponentSlideIns(
                  beginOffset: Offset(2, 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20),
                    child: Text(
                      " Let's personalize your Journey. Fit your lifestyle and get to crossing off Bucket List Items...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ]),
            ),
            ComponentSlideIns(
              beginOffset: Offset(0, 2),
              child: Btns().btn(context, "Let's begin our list", () {
                Navigator.pushNamed(context, "choose_signup");
              }),
            )
          ],
        ),
      ),
    );
  }
}
