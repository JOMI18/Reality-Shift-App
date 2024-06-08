import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

import 'package:reality_shift/imports.dart';

class FullUserProfile extends StatefulWidget {
  const FullUserProfile({super.key});

  @override
  State<FullUserProfile> createState() => _FullUserProfileState();
}

class _FullUserProfileState extends State<FullUserProfile> {
  TextEditingController keyValueCt = TextEditingController();
  AlertInfo alert = AlertInfo();
  final ImagePicker _picker = ImagePicker();

  File? profilePicture;
  bool showProfilePicture = true;
  String? fileName;

  String api = "http://10.0.2.2:8000";
  // String api = "http://realityshift.com";

  Widget _showImage(email, ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _sendToBackEnd(email, ref);
              },
              child: const Row(
                children: [
                  Text(
                    'Confirm Profile',
                    style: const TextStyle(color: Colors.green),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.check_box, color: Colors.green)
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  profilePicture = null;
                  // print(profilePicture);
                  showProfilePicture = false;
                  Navigator.pop(context);
                });
              },
              child: const Row(
                children: [
                  Text(
                    "Remove Image",
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.delete, color: Colors.red)
                ],
              ),
            )
          ],
        ),
        Container(
            height: 30.h,
            decoration: BoxDecoration(border: Border.all(width: 12)),
            child: profilePicture == null
                ? const Text(
                    "No Image Selected",
                    style: TextStyle(color: Colors.black),
                  )
                : Image.file(
                    profilePicture!,
                    fit: BoxFit.contain,
                  )),
        // : Image.asset(
        //     "lib/assets/images/cards/$fileName",
        //     fit: BoxFit.cover,
        //   )),
      ]),
    );
  }

  void _editProfileImage(email, ref) async {
    final img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      final dp = File(img.path);
      fileName = path.basename(img.path.split('\\').last);
      // print(dp);
      setState(() {
        profilePicture = dp;
        showProfilePicture = true;
        CustomBottomSheet.showContent(context, _showImage(email, ref,),38.h);
      });
    }
  }

  void _sendToBackEnd(String email, ref) async {
    FormData data = FormData();

    if (profilePicture != null) {
      data.files.add(MapEntry(
        'profile',
        await MultipartFile.fromFile(
          profilePicture!.path,
          filename: path.basename(profilePicture!.path),
        ),
      ));
    }

    // data.fields.add(MapEntry('email', email));
    data.fields.add(MapEntry('email', "getjommy@gmail.com"));

    AlertLoading().showAlertDialog(context);
    final response = await UserController().profile(data);
    AlertLoading().closeDialog(context);

    print(response);

    if (response['status'] == "error") {
      alert.message = response['message'];
      alert.showAlertDialog(context);
      return;
    }

    ref.read(userProvider.notifier).state =
        UserModel.fromJson(response["user"]);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    // Color newcolor = Utilities().appColors(context).primary;
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "My Personal Information:"),
      body: SingleChildScrollView(
        child: Consumer(builder: (context, ref, _) {
          final user = ref.watch(userProvider.notifier).state;
          final firstname = user.firstname;
          final email = user.email;
          final surname = user.surname;
          final middlename = user.middlename;
          final gender = user.gender;
          final country = user.country;
          final number = user.number;
          final dob = user.dob;
          final profile = user.image;
          final defaultImage = profile == null ? "road.jpg" : profile;

          List items = [
            {"icon": Icons.ac_unit, "key": "Firstname", "value": firstname},
            {
              "icon": Icons.airline_seat_legroom_reduced_rounded,
              "key": "Surname",
              "value": surname
            },
            {
              "icon": Icons.airline_seat_individual_suite_rounded,
              "key": "Middlename",
              "value": middlename
            },
            {
              "icon": Icons.favorite_rounded,
              "key": "Username",
              "value": "$firstname _ $surname"
            },
            {"icon": Icons.email, "key": "Email", "value": email},
            {
              "icon": Icons.person_pin_circle_sharp,
              "key": "Gender",
              "value": gender
            },
            {
              "icon": Icons.local_library_rounded,
              "key": "Country",
              "value": country
            },
            {
              "icon": Icons.phone_android_rounded,
              "key": "Phone number",
              "value": number
            },
            {
              "icon": Icons.calendar_today_rounded,
              "key": "Date of Birth",
              "value": DateFormat('MMM dd, yyyy').format(dob)
            }
          ];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ComponentSlideIns(
                  beginOffset: const Offset(0, -2),
                  child: GestureDetector(
                    onTap: () {
                      _editProfileImage(email, ref);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: profile == null
                          ? AssetImage("lib/assets/images/cards/$defaultImage")
                              as ImageProvider
                          : NetworkImage("$api/UserProfile/$profile"),
                      child: Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: secondary.withOpacity(0.3),
                          ),
                          child: const Icon(Icons.edit, color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Click Image to Edit",
                  style: TextStyle(
                    color: secondary,
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.white.withOpacity(0.4),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ComponentSlideIns(
                            beginOffset: const Offset(2, 0),
                            child: ListTile(
                              leading: Icon(
                                items[index]["icon"],
                                color: secondary,
                              ),
                              title: Text(
                                "${items[index]["key"]}:",
                                style: TextStyle(
                                  color: secondary,
                                ),
                              ),
                              subtitle: Text(
                                items[index]["value"],
                                style: TextStyle(
                                  color: secondary.withOpacity(0.6),
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  CreateNew.showFolderDialog(
                                    context,
                                    name: "Edit ${items[index]["key"]}",
                                    hint: "Enter ${items[index]["key"]}",
                                    action: "Edit",
                                    inputCt: keyValueCt,
                                    onpressed: () {
                                      String value = keyValueCt.text;
                                      if (value != "") {
                                        setState(() {
                                          items[index]["value"] =
                                              value; // Update the value
                                        });
                                        keyValueCt
                                            .clear(); // Clear the text field
                                      } else {
                                        return;
                                      }

                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: secondary.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                          if ((index + 1) % 3 == 0 && index != items.length - 1)
                            Divider(
                              color: Colors.white.withOpacity(0.4),
                            )
                        ],
                      );
                    })
              ],
            ),
          );
        }),
      ),
    );
  }
}


// If the user information can be edited, you could add validation to ensure that the entered data meets certain criteria (e.g., email format validation for the email field).