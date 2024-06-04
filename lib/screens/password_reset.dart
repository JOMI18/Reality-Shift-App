import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  late TextEditingController oldPasswordCt;
  late TextEditingController newPasswordCt;
  late TextEditingController newCPasswordCt;

  bool isPasswordObscure = true;
  bool isCPasswordObscure = true;
  bool isOldPasswordObscure = true;
  // AlertInfo alert = AlertInfo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oldPasswordCt = TextEditingController();
    newPasswordCt = TextEditingController();
    newCPasswordCt = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    oldPasswordCt.dispose();
    newPasswordCt.dispose();
    newCPasswordCt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Forgot Password:"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step 1: What's your old password?",
                  style: TextStyle(fontSize: 20.sp),
                ),
                const SizedBox(
                  height: 20,
                ),
                ComponentSlideIns(
                  beginOffset: const Offset(4, 0),
                  duration: const Duration(milliseconds: 1900),
                  child: CustomTextField.input(context,
                      hint: "xxxxxxxxx",
                      fieldname: "Old Password",
                      controller: oldPasswordCt,
                      obscureText: isOldPasswordObscure,
                      suffixIcon: isOldPasswordObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility), onSuffixIconTap: () {
                    setState(() {
                      isOldPasswordObscure = !isOldPasswordObscure;
                    });
                  }),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Column(
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
                      context, "Navigate to Validation Screen ", () {}),
                )
              ],
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step 3: Create a new password?",
                  style: TextStyle(fontSize: 20.sp),
                ),
                const SizedBox(
                  height: 20,
                ),
                ComponentSlideIns(
                  beginOffset: const Offset(4, 0),
                  duration: const Duration(milliseconds: 1900),
                  child: CustomTextField.input(context,
                      hint: "xxxxxxxxx",
                      fieldname: "New Password",
                      controller: newPasswordCt,
                      obscureText: isPasswordObscure,
                      suffixIcon: isPasswordObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility), onSuffixIconTap: () {
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
                      controller: newCPasswordCt,
                      obscureText: isCPasswordObscure,
                      suffixIcon: isCPasswordObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility), onSuffixIconTap: () {
                    setState(() {
                      isCPasswordObscure = !isCPasswordObscure;
                    });
                  }),
                ),
              ],
            ),
            ComponentSlideIns(
              beginOffset: const Offset(0, 2),
              duration: const Duration(milliseconds: 1200),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Btns().btn(context, "Submit", () {
                      // submit(ref);
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
