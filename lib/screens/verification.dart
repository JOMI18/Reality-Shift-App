import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;
  late TextEditingController _controller6;

  late FocusNode _focusnode1;
  late FocusNode _focusnode2;
  late FocusNode _focusnode3;
  late FocusNode _focusnode4;
  late FocusNode _focusnode5;
  late FocusNode _focusnode6;

  AlertInfo alertInfo = AlertInfo();
  AlertLoading alertLoading = AlertLoading();

  bool codeExpired = false;
  bool canSendAgain = false;
  int remainingSeconds = 0;
  int seconds = 60;

  @override
  void initState() {
    super.initState();

    // Start countdown timer
    startTimer();

    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
    _controller6 = TextEditingController();

    _focusnode1 = FocusNode();
    _focusnode2 = FocusNode();
    _focusnode3 = FocusNode();
    _focusnode4 = FocusNode();
    _focusnode5 = FocusNode();
    _focusnode6 = FocusNode();

    _focusnode1.requestFocus();
  }

  void startTimer() {
    canSendAgain = false;
    setState(() {
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          seconds--;
        });

        if (seconds == 0) {
          timer.cancel();
          setState(() {
            codeExpired = true;
            canSendAgain = true;
          });
        }
      });
    });
  }

  void submit() async {
    // final otp = controller1.text +
    //     controller2.text +
    //     controller3.text +
    //     controller4.text;
    // alertLoading.showAlertDialog(context);
    // alertLoading.closeDialog(context);
  }
  void sendAgain() async {
    setState(() {
      canSendAgain = false;
      remainingSeconds = 60;
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingSeconds--;
      });
      if (remainingSeconds == 0) {
        timer.cancel();
        setState(() {
          canSendAgain = true;
        });
      }
    });
  }

  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();

    _focusnode1.dispose();
    _focusnode2.dispose();
    _focusnode3.dispose();
    _focusnode4.dispose();
    _focusnode5.dispose();
    _focusnode6.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().welcomebar(context, "Email / Number Verification"),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android_rounded,
                size: 60, color: Utilities().appColors(context).secondary),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "Enter the 6-digit code sent to number or email. Never disclose this to anyone!",
              // "Enter the 6-digit code sent to ${Utilities.hidePhoneNumber(user.phone)} or ${Utilities.hideEmailAddress(user.email)}. Never disclose this to anyone!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OtpInputs().otpField(context, _controller1, _focusnode1),
                OtpInputs().otpField(context, _controller2, _focusnode2),
                OtpInputs().otpField(context, _controller3, _focusnode3),
                OtpInputs().otpField(context, _controller4, _focusnode4),
                OtpInputs().otpField(context, _controller5, _focusnode5),
                OtpInputs().otpField(context, _controller6, _focusnode6),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              codeExpired
                  ? "Code Expired, Try Resending..."
                  : "Code expires in $seconds seconds",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 243, 55, 42)),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive the code? ",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    sendAgain();
                  },
                  child: Text(
                    canSendAgain
                        ? 'Send again'
                        : 'Send again in $remainingSeconds seconds',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Utilities().appColors(context).secondary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
