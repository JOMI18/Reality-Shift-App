import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class SignOut extends StatefulWidget {
  const SignOut({super.key});

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  AlertInfo alert = AlertInfo();

  void _signOut(ref) {
    alert.title = "You're signing out now!!!";
    alert.message = "Is this your final decision?";
    alert.showAlertDialog(context, func: () async {
      final user = ref.watch(userProvider.notifier).state;
      String email = user.email;

      AlertLoading().showAlertDialog(context);
      final response = await UserController().signOut(email);
      AlertLoading().closeDialog(context);
      print(response);

      await CustomSharedPreference().remove("username");
      await CustomSharedPreference().remove("last_login");
      Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
    }, name: "yes");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Sign Out"),
      body: Consumer(
        builder: (context, ref, _) {
          return Padding(
            padding: EdgeInsets.fromLTRB(12.0, 60, 12, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset("lib/assets/images/lottie/signout.json"),
                Text(
                  "Leaving So Soon... Are you sure you want to leave?",
                  style: TextStyle(fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                Btns().OtherBtn(context, "Sign Out:", () {
                  _signOut(ref);
                }),
                SizedBox(height: 5.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
