import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController emailCt;
  late TextEditingController passwordCt;
  late TextEditingController cPasswordCt;

  bool isPasswordObscure = true;
  bool isCPasswordObscure = true;
  bool isOldPasswordObscure = true;
  AlertInfo alert = AlertInfo();

  bool isHidden = true;
  bool isEmailReadOnly = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailCt = TextEditingController();
    passwordCt = TextEditingController();
    cPasswordCt = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailCt.dispose();
    passwordCt.dispose();
    cPasswordCt.dispose();
  }

  void submit() async {
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
        isHidden = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      isHidden
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Step 2: Validate your account",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ComponentSlideIns(
                                  beginOffset: const Offset(4, 0),
                                  duration: const Duration(milliseconds: 1900),
                                  child: Btns().OtherBtn(
                                      context, "Navigate to Validation Screen ",
                                      () {
                                    Navigator.pushNamed(
                                        context, "verification");
                                  }),
                                )
                              ],
                            ),
                      SizedBox(
                        height: 4.h,
                      ),
                      // isHidden
                      //     ? Container()
                      //     : Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "Step 3: Create a new password",
                      //             style: TextStyle(fontSize: 20.sp),
                      //           ),
                      //           const SizedBox(
                      //             height: 20,
                      //           ),
                      //           ComponentSlideIns(
                      //             beginOffset: const Offset(4, 0),
                      //             duration: const Duration(milliseconds: 1900),
                      //             child: CustomTextField.input(context,
                      //                 hint: "xxxxxxxxx",
                      //                 fieldname: "New Password",
                      //                 controller: passwordCt,
                      //                 obscureText: isPasswordObscure,
                      //                 suffixIcon: isPasswordObscure
                      //                     ? const Icon(Icons.visibility_off)
                      //                     : const Icon(Icons.visibility),
                      //                 onSuffixIconTap: () {
                      //               setState(() {
                      //                 isPasswordObscure = !isPasswordObscure;
                      //               });
                      //             }),
                      //           ),
                      //           SizedBox(
                      //             height: 2.h,
                      //           ),
                      //           ComponentSlideIns(
                      //             beginOffset: const Offset(4, 0),
                      //             duration: const Duration(milliseconds: 1900),
                      //             child: CustomTextField.input(context,
                      //                 hint: "xxxxxxxxx",
                      //                 fieldname: "Confirm New Password",
                      //                 controller: cPasswordCt,
                      //                 obscureText: isCPasswordObscure,
                      //                 suffixIcon: isCPasswordObscure
                      //                     ? const Icon(Icons.visibility_off)
                      //                     : const Icon(Icons.visibility),
                      //                 onSuffixIconTap: () {
                      //               setState(() {
                      //                 isCPasswordObscure = !isCPasswordObscure;
                      //               });
                      //             }),
                      //           ),
                      //         ],
                      //       ),
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
                          Btns().btn(context, "Submit", () {
                            submit();
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
