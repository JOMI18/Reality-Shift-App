import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String api = "http://10.0.2.2:8000";

  bool _showDp = false;

  List data = [
    {
      "key": "Account",
      "child": [
        {"route": "full_user_profile", "tab": "User Information"},
        {"route": "", "tab": "Download your Data"},
        {"route": "favs", "tab": "View your Boards"},
        {"route": "", "tab": "Deactivate or Delete your Account"},
        {"route": "", "tab": "Log Out"}
      ]
    },
    {
      "key": "Settings and Privacy",
      "child": [
        {"route": "", "tab": "Activate Biometrics"},
        {"route": "", "tab": "About"},
        {"route": "", "tab": "Language"},
        {"route": "", "tab": "Notifications"},
        {"route": "app_theme", "tab": "App Theme Mode"},
        {"route": "", "tab": "Report a Problem"},
        {"route": "", "tab": "Terms and Policies"},
      ]
    }
  ];

  void _displayProfile(defaultImage, profile) {
    print("object");
    setState(() {
      _showDp = true;
      CustomBottomSheet.showContent(
          context, _showImage(defaultImage, profile), 70.h);
    });
  }

  Widget _showImage(defaultImage, profile) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
          onTap: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Close Image",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(width: 12),
              Icon(Icons.close_rounded, color: Colors.red)
            ],
          ),
        ),
        Container(
          height: 48.h,
          width: 70.w,
          decoration: BoxDecoration(border: Border.all(width: 12)),
          child: profile == null
              ? Image.asset("lib/assets/images/cards/$defaultImage")
              : Image.network("$api/UserProfile/$profile"),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Manage My UserProfile:"),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, _) {
            final user = ref.watch(userProvider.notifier).state;
            final firstname = user.firstname;
            final email = user.email;
            final surname = user.surname;
            final profile = user.image;
            final defaultImage =
                profile ?? "road.jpg"; // same as when testing for null
            // final defaultImage = profile == null ? "road.jpg" : profile;

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ComponentSlideIns(
                    beginOffset: const Offset(2, 0),
                    child: Container(
                      height: 15.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(210, 254, 254, 254),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _displayProfile(defaultImage, profile);
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: profile == null
                                  ? AssetImage(
                                          "lib/assets/images/cards/$defaultImage")
                                      as ImageProvider
                                  : NetworkImage("$api/UserProfile/$profile"),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$firstname $surname ",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "Email: $email",
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "full_user_profile");
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white),
                                    child: const Text(
                                      "Edit",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  GestureDetector(
                                      onTap: () {},
                                      child:
                                          const Icon(Icons.ios_share_outlined)),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Icon(
                                          Icons.drag_indicator_sharp))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]["key"],
                                  style: TextStyle(fontSize: 19.sp),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ComponentSlideIns(
                                  beginOffset: const Offset(-2, 0),
                                  child: Card(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: data[index]["child"].length,
                                      itemBuilder: (context, childIndex) {
                                        final childItem =
                                            data[index]["child"][childIndex];
                                        // print(childItem);
                                        return ListTile(
                                          title: Text(childItem["tab"]),
                                          onTap: () {
                                            if (childItem["route"] == "" ||
                                                childItem["route"] == null) {
                                              return;
                                            } else {
                                              Navigator.pushNamed(
                                                  context, childItem["route"]);
                                            }
                                          },
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            size: 15,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                      SizedBox(
                        height: 3.h,
                      ),
                      const Text("Version 1.0.0.00.1"),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
