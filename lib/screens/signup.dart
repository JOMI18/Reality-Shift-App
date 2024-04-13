import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController surnameCt;
  late TextEditingController firstnameCt;
  late TextEditingController middlenameCt;
  late TextEditingController dobCt;
  late TextEditingController emailCt;
  late TextEditingController numCt;
  late TextEditingController passwordCt;
  late TextEditingController cfpasswordCt;
  late TextEditingController genderCt;

  bool isPasswordObscure = false;
  bool isCfPasswordObscure = false;
  AlertInfo alert = AlertInfo();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    surnameCt = TextEditingController();
    firstnameCt = TextEditingController();
    middlenameCt = TextEditingController();
    dobCt = TextEditingController();
    emailCt = TextEditingController();
    numCt = TextEditingController();
    passwordCt = TextEditingController();
    cfpasswordCt = TextEditingController();
    genderCt = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    surnameCt.dispose();
    firstnameCt.dispose();
    middlenameCt.dispose();
    dobCt.dispose();
    emailCt.dispose();
    numCt.dispose();
    passwordCt.dispose();
    cfpasswordCt.dispose();
    genderCt.dispose();
  }

  void submit() {
    // FORT-- RETURNS AT FIRST TRUTH
    if (surnameCt.text == "" ||
        firstnameCt.text == "" ||
        middlenameCt.text == "" ||
        dobCt.text == "" ||
        emailCt.text == "" ||
        numCt.text == "" ||
        passwordCt.text == "" ||
        cfpasswordCt == "") {
      alert.message = "Sorry, you can't proceed no value was entered!";
      alert.showAlertDialog(context);
      // return;
    }
    if (cfpasswordCt.text != passwordCt.text) {
      alert.message = "Passwords not match";
      alert.showAlertDialog(context);
      return;
    }

// confirm email
    Navigator.pushNamed(context, "verification");
// then straight to dashboard

// also log in
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // dismisses the keyboard on tap outside the input
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar().welcomebar(context, "Welcome to Reality Shift"),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SignUp:",
                    style: TextStyle(fontSize: 22.sp),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "We're glad to embark on this journey with you. Please fill in your details to get started.",
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
                      ComponentSlideIns(
                        beginOffset: Offset(2, 0),
                        duration: Duration(milliseconds: 1200),
                        child: CustomTextField.input(context,
                            hint: "Reyes",
                            fieldname: "Surname",
                            controller: surnameCt),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(2, 0),
                        duration: Duration(milliseconds: 1300),
                        child: CustomTextField.input(context,
                            hint: "Jonathan",
                            fieldname: "Firstname",
                            controller: firstnameCt),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(2, 0),
                        duration: Duration(milliseconds: 1400),
                        child: CustomTextField.input(context,
                            hint: "Smith",
                            fieldname: "Middlename",
                            controller: middlenameCt),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(3, 0),
                        duration: Duration(milliseconds: 1500),
                        child: CustomTextField.input(context,
                            hint: "mm-dd-yyyy", readOnly: true, onTap: () {
                          CustomBottomSheet.showDatePicker(context,
                              onDateSelected: (date) {
                            dobCt.text = "$date";
                          });
                        },
                            suffixIcon: Icon(Icons.calendar_today),
                            fieldname: "Date of Birth",
                            controller: dobCt),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(3, 0),
                        duration: Duration(milliseconds: 1600),
                        child: CustomTextField.input(context,
                            suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                            hint: "male",
                            readOnly: true, onTap: () {
                          CustomBottomSheet.showGenderSelection(context,
                              onSelect: (gender) {
                            genderCt.text = gender;
                          });
                        }, fieldname: "Gender", controller: genderCt),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(3, 0),
                        duration: Duration(milliseconds: 1700),
                        child: CustomTextField.input(context,
                            hint: "jonathansmith21@gmail.com",
                            fieldname: "Email",
                            controller: emailCt),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(3, 0),
                        duration: Duration(milliseconds: 1800),
                        child: CustomTextField.input(context,
                            hint: "xxx-xxx-xxx",
                            fieldname: "Phone Number",
                            controller: numCt),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(4, 0),
                        duration: Duration(milliseconds: 1900),
                        child: CustomTextField.input(context,
                            hint: "xxxxxxxxx",
                            fieldname: "Password",
                            controller: passwordCt,
                            obscureText: isPasswordObscure,
                            suffixIcon: isPasswordObscure
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility), onSuffixIconTap: () {
                          setState(() {
                            isPasswordObscure = !isPasswordObscure;
                          });
                        }),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ComponentSlideIns(
                        beginOffset: Offset(4, 0),
                        duration: Duration(milliseconds: 2000),
                        child: CustomTextField.input(context,
                            hint: "xxxxxxxxx",
                            fieldname: "Confirm Password",
                            controller: cfpasswordCt,
                            obscureText: isCfPasswordObscure,
                            suffixIcon: isCfPasswordObscure
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility), onSuffixIconTap: () {
                          setState(() {
                            isCfPasswordObscure = !isCfPasswordObscure;
                          });
                        }),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
                ),
              ),
              ComponentSlideIns(
                beginOffset: Offset(0, 2),
                duration: Duration(milliseconds: 1200),
                child: Column(
                  children: [
                    Btns().btn(context, "Submit", () {
                      submit();
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
