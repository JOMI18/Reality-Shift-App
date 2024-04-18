import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController email_numCt;
  late TextEditingController passwordCt;

  bool isPasswordObscure = false;
  AlertInfo alert = AlertInfo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email_numCt = TextEditingController();
    passwordCt = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email_numCt.dispose();
    passwordCt.dispose();
  }

  void submit(ref) async {
    // Navigator.pushNamed(context, "dashboard");
    // return;
    // FORT-- RETURNS AT FIRST TRUTH
    if (email_numCt.text == "" || passwordCt.text == "") {
      alert.message = "Sorry, you can't proceed no value was entered!";
      alert.showAlertDialog(context);
      return;
    }

    Map formData = {};

    formData["email"] = email_numCt.text;
    formData["password"] = passwordCt.text;

    // ref.read(signUpProvider.notifier).state = formData;
    // print(formData);

    // SystemChannels.textInput.invokeMethod("TextInput.hide");

    AlertLoading().showAlertDialog(context);
    final response = await AuthController().register(formData);
    AlertLoading().closeDialog(context);

    print(response);

    if (response['status'] == "error") {
      alert.message = response['message'];
      alert.showAlertDialog(context);
      return;
    }

    print(response);

    ref.read(userProvider.notifier).state =
        UserModel.fromJson(response["user"]);

    // pref.setString("token", response["token"]);

    Navigator.pushNamed(context, "dashboard");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar().welcomebar(context, "Welcome back, Jonathan Smith!"),
      body: Consumer(
        builder: (context, ref, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 21),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Log In:",
                      style: TextStyle(fontSize: 22.sp),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "We're glad to embark on this journey with you. Please fill in your details to reality shift.",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        ComponentSlideIns(
                          beginOffset: const Offset(3, 0),
                          duration: const Duration(milliseconds: 1700),
                          child: CustomTextField.input(context,
                              hint: "jonathansmith21@gmail.com",
                              fieldname: "Email",
                              controller: email_numCt),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        ComponentSlideIns(
                          beginOffset: const Offset(4, 0),
                          duration: const Duration(milliseconds: 1900),
                          child: CustomTextField.input(context,
                              hint: "xxxxxxxxx",
                              fieldname: "Password",
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "forgotpin");
                          },
                          child: Text(
                            "Forgot PIN?",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Utilities().appColors(context).primary),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.fingerprint_rounded,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ComponentSlideIns(
                          beginOffset: const Offset(0, 4),
                          duration: const Duration(milliseconds: 1200),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Not Jonathan?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "signout");
                                },
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Utilities()
                                          .appColors(context)
                                          .secondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          submit(ref);
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
