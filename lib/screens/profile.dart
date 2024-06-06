import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Manage My UserProfile:"),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, _) {
            final firstname = ref.watch(userProvider.notifier).state.firstname;
            final email = ref.watch(userProvider.notifier).state.email;
            final surname = ref.watch(userProvider.notifier).state.surname;

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
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                "lib/assets/images/backgrounds/day.jpg"),
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
                                    onPressed: () {},
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
