import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:reality_shift/imports.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  List alerts = [
    {"key": "Fashion in Korea", "date": DateFormat("W").format(DateTime.now())},
    {
      "key": "Culture in America",
      "date": DateFormat("W").format(DateTime.now())
    },
    {
      "key": "Studying in Europe",
      "date": DateFormat("W").format(DateTime.now())
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Recent Notifications:"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListView.builder(
              itemCount: alerts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final key = alerts[index]["key"];
                final date = alerts[index]["date"];
                return Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 22,
                        backgroundImage:
                            AssetImage("lib/assets/images/cards/veggies.jpg"),
                      ),
                      title: Text(
                        "You added a note on $key",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Text(
                        date.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
