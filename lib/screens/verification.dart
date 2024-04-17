import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  Timer? _timer; // Declare timer variable

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
  bool canSendAgain = true;
  int remainingSeconds = 0;
  int seconds = 60;

  var email;
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
    // Start countdown timer for OTP expiration
    codeExpired = false;
    setState(() {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          seconds--;
        });

        if (seconds == 0) {
          timer.cancel();
          setState(() {
            codeExpired = true;
          });
        }
      });
    });
  }

  void submit() async {
    final otp = _controller1.text +
        _controller2.text +
        _controller3.text +
        _controller4.text +
        _controller5.text +
        _controller6.text;

    alertLoading.showAlertDialog(context);
    final response =
        await AuthController().checkOtp({"otp": otp, "email": email});
    alertLoading.closeDialog(context);

    print(response);
    Navigator.pushNamed(context, "dashboard");
  }

  void sendAgain() async {
    setState(() {
      canSendAgain = false;
      codeExpired = true;
      remainingSeconds = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar().welcomebar(context, "Two-Factor Authentication"),
        body: Consumer(
          builder: (context, ref, _) {
            email = ref.watch(signUpProvider)['email'];
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_android_rounded,
                      size: 60,
                      color: Utilities().appColors(context).secondary),
                  SizedBox(
                    height: 6.h,
                  ),
                  ComponentSlideIns(
                    beginOffset: Offset(-2, 0),
                    child: Text(
                      "A message with a 6-digit verification code has been sent to number or email. Please enter the code to continue. Never disclose this to anyone!",
                      // "Enter the 6-digit code sent to ${Utilities.hidePhoneNumber(user.phone)} or ${Utilities.hideEmailAddress(user.email)}. Never disclose this to anyone!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ComponentSlideIns(
                    beginOffset: Offset(2, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OtpInputs().otpField(context, _controller1, _focusnode1,
                            nextFocusNode: _focusnode2),
                        OtpInputs().otpField(context, _controller2, _focusnode2,
                            prevFocusNode: _focusnode1,
                            nextFocusNode: _focusnode3),
                        OtpInputs().otpField(context, _controller3, _focusnode3,
                            prevFocusNode: _focusnode2,
                            nextFocusNode: _focusnode4),
                        OtpInputs().otpField(context, _controller4, _focusnode4,
                            prevFocusNode: _focusnode3,
                            nextFocusNode: _focusnode5),
                        OtpInputs().otpField(context, _controller5, _focusnode5,
                            prevFocusNode: _focusnode4,
                            nextFocusNode: _focusnode6),
                        OtpInputs().otpField(context, _controller6, _focusnode6,
                            isLast: true,
                            func: submit,
                            prevFocusNode: _focusnode5),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ComponentSlideIns(
                    beginOffset: Offset(-2, 0),
                    child: Text(
                      canSendAgain
                          ? codeExpired
                              ? "Code Expired, Try Resending..."
                              : "Code expires in $seconds seconds"
                          : "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 243, 55, 42)),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ComponentSlideIns(
                    beginOffset: Offset(0, 4),
                    child: Row(
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
                                ? "Send Again"
                                : 'Send again in $remainingSeconds seconds',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color:
                                    Utilities().appColors(context).secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
