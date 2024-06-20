import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class AlertSuccess {
  Future displayLottie(context, screen) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Lottie.asset(
                'lib/assets/images/lottie/success.json',
                repeat: false,
                onLoaded: (composition) {
                  Future.delayed(composition.duration, () {
                    Navigator.of(context)
                        .pop(); // Close the dialog after animation
                    Navigator.pushNamedAndRemoveUntil(
                        context, "$screen", (route) => false);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
