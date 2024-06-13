import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reality_shift/imports.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

List texts = [
  {
    "heading": "Welcome to Reality Shift",
    "content":
        "Explore, Experience, and Embrace New Realities! Your Portal to the World's Wonders!"
  },
  {
    "heading": "What is Reality Shift About?",
    "content":
        "Reality Shift is your ultimate travel companion, designed to help you explore the world, traverse cultures, and embrace new realities from the comfort of your device. Whether you're planning your next adventure or simply curious about different parts of the globe, Reality Shift provides you with all the information and tools you need to make your travel dreams a reality.",
  },
  {
    "heading": "Our Mission:",
    "content":
        "At Reality Shift, our mission is to make exploring the world accessible and enjoyable for everyone. We believe that travel enriches our lives, broadens our perspectives, and connects us with diverse cultures. Through our app, we aim to inspire and facilitate your journey, whether it's a weekend getaway or a lifelong adventure."
  },
];

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "About Reality Shift:"),
      body: Consumer(
        builder: (context, ref, _) {
          final user = ref.read(userProvider.notifier).state;
          final created = DateFormat("MMM dd, yyyy").format(user.createdAt);

          List item = [
            {
              "icon": Icons.calendar_month,
              "name": "Date Joined",
              "route": null,
              "value": created,
            },
            {
              "icon": Icons.book,
              "name": "Open Source libraries",
              "route": "",
              "value": "used in development",
              // "value": null,
            },
            {
              "icon": Icons.badge_sharp,
              "name": "Version",
              "route": null,
              "value": "1.0.0.00.1",
            }
          ];

          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: texts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ComponentSlideIns(
                            beginOffset: const Offset(0, 2),
                            child: Text(
                              texts[index]["heading"],
                              style:
                                  TextStyle(fontSize: 19.sp, color: secondary),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ComponentSlideIns(
                            beginOffset: const Offset(2, 0),
                            child: Text(
                              texts[index]["content"],
                              style: const TextStyle(
                                  letterSpacing: 1.2, height: 1.8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  ListView.builder(
                    itemCount: item.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ComponentSlideIns(
                        beginOffset: const Offset(-2, 0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(item[index]["icon"]),
                              trailing: (index == 1)
                                  ? const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18,
                                    )
                                  : const Text(""),
                              title: Text(
                                item[index]["name"],
                                style: TextStyle(color: secondary),
                              ),
                              subtitle: Text(
                                item[index]["value"] ?? "",
                                style: TextStyle(
                                    color: secondary.withOpacity(0.6)),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
