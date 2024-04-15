import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';
import 'package:reality_shift/transitions/item_slide_ins.dart';

class ChooseSignUp extends StatefulWidget {
  @override
  State<ChooseSignUp> createState() => _ChooseSignUpState();
}

class _ChooseSignUpState extends State<ChooseSignUp> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  // configure apple and google sign in properly
  Future<void> _handleAppleSignUp() async {
    try {
      // final result = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      //   webAuthenticationOptions: WebAuthenticationOptions(
      //     clientId: 'your_client_id',
      //     redirectUri: Uri.parse('your_redirect_uri'),
      //   ),
      // );
      // // Handle Apple sign-in result and retrieve user details from 'result'
    } catch (error) {
      AlertInfo().message = "An Error has occured";
      AlertInfo().showAlertDialog(context);
    }
  }

  Future<void> _handleGoogleSignUp() async {
    try {
      // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      // if (googleUser != null) {
      //   // User signed up, handle user details
      //   String userEmail = googleUser.email;
      //   // Handle other user details as needed
      // } else {
      //   // User cancelled Google sign-up
      // }
    } catch (error) {
      // Handle sign-up errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().welcomebar(context, "Chooose How to Sign Up:"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ComponentSlideIns(
              beginOffset: Offset(2, 0),
              child: Text(
                "Here are 3 ways to Create an Account. Choose your preferred platform",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            Column(
              children: [
                // Custom Apple Widget

                // SignInWithAppleButton(
                //   onPressed: _handleAppleSignUp,
                //   text: 'Sign Up with Apple',
                // ),

                ComponentSlideIns(
                  beginOffset: Offset(-2, 0),
                  child: Btns().buildButton(context,
                      text: 'Continue with Apple',
                      icon: const Icon(
                        Icons.apple_rounded,
                        size: 30,
                      ),
                      backgroundColor: Colors.black, onPressed: () {
                    _handleAppleSignUp;
                  }),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Text("OR"),
                SizedBox(
                  height: 2.h,
                ),

                ComponentSlideIns(
                  beginOffset: Offset(2, 0),
                  child: Btns().buildButton(context,
                      text: 'Continue with Google',
                      icon: Image.asset(
                        "lib/assets/images/google-logo.jpeg",
                        height: 35,
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white, onPressed: () {
                    _handleGoogleSignUp;
                  }),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Text("OR"),
                SizedBox(
                  height: 2.h,
                ),

                ComponentSlideIns(
                  beginOffset: Offset(-2, 0),
                  child: Btns().buildButton(context,
                      text: 'Continue with Reality Shift',
                      icon: Image.asset(
                        "lib/assets/images/logo-icon.png",
                        height: 30,
                      ),
                      foregroundColor: Utilities().appColors(context).secondary,
                      backgroundColor: Utilities().appColors(context).primary,
                      onPressed: () {
                    Navigator.pushNamed(context, "signup");
                  }),
                ),
              ],
            ),
            ComponentSlideIns(
              beginOffset: Offset(0, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "login");
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Utilities().appColors(context).secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
