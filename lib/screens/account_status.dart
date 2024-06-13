import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class AccountStatus extends StatefulWidget {
  const AccountStatus({super.key});

  @override
  State<AccountStatus> createState() => _AccountStatusState();
}

class _AccountStatusState extends State<AccountStatus> {
  AlertInfo alert = AlertInfo();
  void _deactivate() {
    alert.title = "Deactivating your account is temporary";
    alert.message =
        "Your profile, photos, comments and likes will be hidden until you enable it by logging back in.";

    alert.showAlertDialog(context, func: () {
      _sendToBackend();
    });
  }

  void _delete() {
    alert.title = "Deleting your account is permanent";
    alert.message =
        "Your profile, photos, videos, comments, likes and followers will be permanently deleted. Look through options to download your data";
    alert.showAlertDialog(context, func: () {
      _sendToBackend();
    });
  }

  void _sendToBackend() {
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Account Status"),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Determine the status of your account: ",
              style: TextStyle(fontSize: 19.sp),
            ),
            Lottie.asset("lib/assets/images/lottie/account_status.json"),
            SizedBox(height: 5.h),
            Text(
              "I want to deactivate my account",
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(height: 2.h),
            Btns().OtherBtn(context, "Deactivate", () {
              _deactivate();
            }),
            SizedBox(height: 5.h),
            Text(
              "I would like to delete my account",
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(height: 2.h),
            Btns().OtherBtn(context, "Delete", () {
              _delete();
            }),
          ],
        ),
      ),
    );
  }
}
