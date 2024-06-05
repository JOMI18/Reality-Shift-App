import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController emailCt;
  late TextEditingController codeCt;
  late TextEditingController passwordCt;
  late TextEditingController cPasswordCt;

  Timer? _ResendTimer;

  bool isPasswordObscure = true;
  bool isCPasswordObscure = true;

  AlertInfo alert = AlertInfo();

  bool isEmailReadOnly = false;
  bool isCodeReadOnly = false;
  bool isStep2Visible = false;
  bool isStep3Visible = false;

  bool canSendAgain = true;
  int remainingSeconds = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailCt = TextEditingController();
    codeCt = TextEditingController();
    passwordCt = TextEditingController();
    cPasswordCt = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailCt.dispose();
    codeCt.dispose();
    passwordCt.dispose();
    cPasswordCt.dispose();
    _ResendTimer?.cancel();
  }

  void checkEmail() async {
    if (emailCt.text == "") {
      alert.message = "Email can't be empty";
      alert.showAlertDialog(context);
      return;
    }

    AlertLoading().showAlertDialog(context);
    final response =
        await AuthController().checkAccount({"email": emailCt.text});
    AlertLoading().closeDialog(context);

    print(response);

    if (response["status"] == "error") {
      alert.message = response['message'];
      alert.showAlertDialog(context);
      return;
    }

    setState(() {
      if (response["status"] != "error") {
        isEmailReadOnly = true;
        isStep2Visible = true;
      }
    });
  }

  void sendAgain() async {
    setState(() {
      canSendAgain = false;
      remainingSeconds = 60;
    });

    _ResendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

    final response = await AuthController().sendOtp({"email": emailCt.text});
    print(response);
  }

  void checkCode() async {
    if (codeCt.text == "") {
      alert.message = "Code can't be empty";
      alert.showAlertDialog(context);
      return;
    }

    AlertLoading().showAlertDialog(context);
    final response = await AuthController()
        .checkOtp({"otp": codeCt.text, "email": emailCt.text});
    AlertLoading().closeDialog(context);

    print(response);

    if (response["status"] == "error") {
      alert.message = response['message'];
      alert.showAlertDialog(context);
      return;
    }

    setState(() {
      if (response["status"] != "error") {
        isCodeReadOnly = true;
        isStep3Visible = true;
      }
    });
  }

  void resetPassword() async {
    if (passwordCt.text == "" || cPasswordCt.text == "") {
      alert.message = "Passwords can't be empty";
      alert.showAlertDialog(context);
      return;
    }

    if (cPasswordCt.text != passwordCt.text) {
      alert.message = "Passwords do not match";
      alert.showAlertDialog(context);
      return;
    }

    AlertLoading().showAlertDialog(context);
    final response = await AuthController().resetPassword({
      "password": passwordCt.text,
      'password_confirmation': cPasswordCt.text,
      "email": emailCt.text
    });
    AlertLoading().closeDialog(context);

    print(response);

    if (response["status"] == "error") {
      alert.message = response['message'];
      alert.showAlertDialog(context);
      return;
    }
    // ref.read(userProvider.notifier).state =
    //     UserModel.fromJson(response["user"]);

    Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar().generalbar(context, "Forgot Password:"),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ComponentSlideIns(
                            beginOffset: const Offset(-2, 0),
                            duration: const Duration(milliseconds: 1200),
                            child: Text(
                              "Step 1: What's your Email?",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ComponentSlideIns(
                              beginOffset: const Offset(2, 0),
                              duration: const Duration(milliseconds: 1400),
                              child: CustomTextField.input(
                                context,
                                hint: "jonathansmith21@gmail.com",
                                fieldname: "Email",
                                readOnly: isEmailReadOnly,
                                controller: emailCt,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      isStep2Visible
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ComponentSlideIns(
                                  beginOffset: const Offset(-2, 0),
                                  duration: const Duration(milliseconds: 1200),
                                  child: Text(
                                    "Step 2: Validate your account",
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // ComponentSlideIns(
                                //   beginOffset: const Offset(4, 0),
                                //   duration: const Duration(milliseconds: 1900),
                                //   child: Btns().OtherBtn(
                                //       context, "Navigate to Validation Screen ",
                                //       () {
                                //     Navigator.pushNamed(
                                //         context, "verification");
                                //   }),
                                // )
                                ComponentSlideIns(
                                    beginOffset: const Offset(2, 0),
                                    duration:
                                        const Duration(milliseconds: 1400),
                                    child: CustomTextField.input(
                                      context,
                                      hint: "Enter the 6 digit code",
                                      fieldname: "Verification Code",
                                      readOnly: isCodeReadOnly,
                                      controller: codeCt,
                                    )),
                                const SizedBox(
                                  height: 4,
                                ),
                                ComponentSlideIns(
                                  beginOffset: const Offset(0, 4),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Didn't receive the code? ",
                                        style: TextStyle(
                                          fontSize: 15,
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
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: secondary),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 4.h,
                      ),
                      isStep3Visible
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ComponentSlideIns(
                                  beginOffset: const Offset(-2, 0),
                                  duration: const Duration(milliseconds: 1200),
                                  child: Text(
                                    "Step 3: Create a new password",
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ComponentSlideIns(
                                  beginOffset: const Offset(2, 0),
                                  duration: const Duration(milliseconds: 1400),
                                  child: CustomTextField.input(context,
                                      hint: "xxxxxxxxx",
                                      fieldname: "New Password",
                                      controller: passwordCt,
                                      obscureText: isPasswordObscure,
                                      suffixIcon: isPasswordObscure
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                      onSuffixIconTap: () {
                                    setState(() {
                                      isPasswordObscure = !isPasswordObscure;
                                    });
                                  }),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                ComponentSlideIns(
                                  beginOffset: const Offset(4, 0),
                                  duration: const Duration(milliseconds: 1900),
                                  child: CustomTextField.input(context,
                                      hint: "xxxxxxxxx",
                                      fieldname: "Confirm New Password",
                                      controller: cPasswordCt,
                                      obscureText: isCPasswordObscure,
                                      suffixIcon: isCPasswordObscure
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                      onSuffixIconTap: () {
                                    setState(() {
                                      isCPasswordObscure = !isCPasswordObscure;
                                    });
                                  }),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  // Text("Need to Reset"),
                  ComponentSlideIns(
                    beginOffset: const Offset(0, 2),
                    duration: const Duration(milliseconds: 1200),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Btns().btn(
                              context,
                              isStep3Visible
                                  ? "Change Password"
                                  : isStep2Visible
                                      ? "Validate Code"
                                      : "Check Email", () {
                            isStep3Visible
                                ? resetPassword()
                                : isStep2Visible
                                    ? checkCode()
                                    : checkEmail();
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
