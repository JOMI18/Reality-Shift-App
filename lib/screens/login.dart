import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailCt;
  late TextEditingController passwordCt;

  bool isPasswordObscure = true;
  AlertInfo alert = AlertInfo();

  String? username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailCt = TextEditingController();
    passwordCt = TextEditingController();
    checkForReturningUser();
  }

  Future<void> checkForReturningUser() async {
    String? storedUsername =
        await CustomSharedPreference().getString("username");
    String? lastLoginString =
        await CustomSharedPreference().getString("last_login");

    if (storedUsername != null && lastLoginString != null) {
      DateTime lastLogin = DateTime.parse(lastLoginString);
      if (DateTime.now().difference(lastLogin).inDays < 7) {
        // For example, a 7-day window
        setState(() {
          username = storedUsername;
        });
      } else {
        // Clear old user info
        await CustomSharedPreference().remove("username");
        await CustomSharedPreference().remove("last_login");
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailCt.dispose();
    passwordCt.dispose();
  }

  void submit(ref) async {
    // FORT-- RETURNS AT FIRST TRUTH
    if (emailCt.text == "" || passwordCt.text == "") {
      alert.message = "Sorry, you can't proceed no value was entered!";
      alert.showAlertDialog(context);
      return;
    }

    var deviceinfo = await Utilities().devicePlatform;
    Map formData = {};

    formData["email"] = emailCt.text;
    formData["password"] = passwordCt.text;
    formData['device_id'] = deviceinfo['id'];
    formData['device_model'] = deviceinfo['model'];

    ref.read(signUpProvider.notifier).state = formData;
    print(formData);

    AlertLoading().showAlertDialog(context);
    final response = await AuthController().login(formData);
    AlertLoading().closeDialog(context);
    print(response);

    if (response['status'] == "error") {
      alert.message = response['message'];
      alert.showAlertDialog(context);
      return;
    }

    ref.read(userProvider.notifier).state =
        UserModel.fromJson(response["user"]);

    pref.setString("token", response["token"]);
    String username = response["user"]["firstname"];
    await storeUserInfo(username);

    Navigator.pushNamed(context, "dashboard");
  }

  Future<void> storeUserInfo(String username) async {
    await CustomSharedPreference().setString("username", username);
    await CustomSharedPreference()
        .setString("last_login", DateTime.now().toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;

    return Consumer(builder: (context, ref, _) {
      // final user = ref.read(userProvider.notifier).state;
      // print(user.firstname);
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: CustomAppBar()
                .welcomebar(context, "Welcome Back, ${username ?? "User"} !!"),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
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
                                controller: emailCt),
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
                            height: 8.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "forgot_pin");
                            },
                            child: Text(
                              "Forgot PIN?",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: secondary),
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
                                Text(
                                  "Not ${username ?? "User"}?",
                                  style: const TextStyle(
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
            )),
      );
    });
  }
}
