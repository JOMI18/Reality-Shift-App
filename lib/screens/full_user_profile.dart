import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reality_shift/imports.dart';

class FullUserProfile extends StatefulWidget {
  const FullUserProfile({super.key});

  @override
  State<FullUserProfile> createState() => _FullUserProfileState();
}

class _FullUserProfileState extends State<FullUserProfile> {
  TextEditingController keyValueCt = TextEditingController();
  List items = [
    {"icon": Icons.ac_unit, "key": "Firstname", "value": "Jonathan"},
    {
      "icon": Icons.airline_seat_legroom_reduced_rounded,
      "key": "Surname",
      "value": "Smith"
    },
    {
      "icon": Icons.airline_seat_individual_suite_rounded,
      "key": "Middlename",
      "value": "Reyes"
    },
    {
      "icon": Icons.favorite_rounded,
      "key": "Username",
      "value": "JonathanReyes_Smith"
    },
    {"icon": Icons.email, "key": "Email", "value": "jonathansmith21@gmail.com"},
    {"icon": Icons.person_pin_circle_sharp, "key": "Gender", "value": "Female"},
    {"icon": Icons.local_library_rounded, "key": "Country", "value": "Nigeria"},
    {
      "icon": Icons.phone_android_rounded,
      "key": "Phone number",
      "value": "080224576834"
    },
    {
      "icon": Icons.calendar_today_rounded,
      "key": "Date of Birth",
      "value": "July 21, 2024"
    },
  ];

  @override
  Widget build(BuildContext context) {
    Color rootcolor = Utilities().appColors(context).secondary;
    // Color newcolor = Utilities().appColors(context).primary;
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "My Personal Information:"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ComponentSlideIns(
                beginOffset: Offset(0, -2),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      AssetImage("lib/assets/images/cards/bread.jpg"),
                  child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: rootcolor.withOpacity(0.3),
                      ),
                      child: Icon(Icons.edit, color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Click Image to Edit",
                style: TextStyle(
                  color: rootcolor,
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
                          beginOffset: Offset(2, 0),
                          child: ListTile(
                            leading: Icon(
                              items[index]["icon"],
                              color: rootcolor,
                            ),
                            title: Text(
                              "${items[index]["key"]}:",
                              style: TextStyle(
                                color: rootcolor,
                              ),
                            ),
                            subtitle: Text(
                              items[index]["value"],
                              style: TextStyle(
                                color: rootcolor.withOpacity(0.6),
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
                                color: rootcolor.withOpacity(0.6),
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
        ),
      ),
    );
  }
}


// If the user information can be edited, you could add validation to ensure that the entered data meets certain criteria (e.g., email format validation for the email field).