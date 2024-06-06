import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reality_shift/imports.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailCt;
  late TextEditingController passwordCt;

  final LocalAuthentication auth = LocalAuthentication();
  // ignore: unused_field
  bool _canCheckBiometrics = false;
  bool _isAuthenticated = false;

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
    _checkBiometrics();
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
    String email = response["user"]["email"];
    // String password = response["user"]["password"];

    // await storeUserInfo(username, email, password);
    await storeUserInfo(username, email);
    Navigator.pushNamed(context, "dashboard");
  }

  Future<void> storeUserInfo(String username, email) async {
    // Future<void> storeUserInfo(String username, email, password) async {
    await CustomSharedPreference().setString("username", username);
    await CustomSharedPreference()
        .setString("last_login", DateTime.now().toIso8601String());

    await CustomSharedPreference().setString("email", email);
    // await CustomSharedPreference().setString("password", password);
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      canCheckBiometrics = false;
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async {
    print("object");
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'NotAvailable') {
        alert.message =
            "Biometric authentication is not available. Please set up biometrics on your device.";
        alert.showAlertDialog(context);
      }
    } catch (e) {
      print(e); // For any other exceptions
    }

    if (!mounted) return;

    setState(() {
      _isAuthenticated = authenticated;
      if (_isAuthenticated) {
        // Autofill email and password fields
        emailCt.text = username ?? '';
        passwordCt.text =
            'your_saved_password'; // You should retrieve this securely
      }
    });

    await _fillCredentials();
  }

  Future<void> _fillCredentials() async {
    String? storedEmail = await CustomSharedPreference().getString("email");
    String? storedPassword =
        await CustomSharedPreference().getString("password");

    if (storedEmail != null && storedPassword != null) {
      setState(() {
        emailCt.text = storedEmail;
        passwordCt.text = storedPassword;
      });
    }
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
                            onTap: () {
                              _authenticate();
                            },
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
