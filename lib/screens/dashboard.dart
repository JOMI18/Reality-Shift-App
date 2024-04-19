import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  final List bodyWidget = [
    const Home(),
    const Continents(),
    const Notes(),
    const Pins(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyWidget.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        selectedItemColor: Utilities().appColors(context).secondary,
        unselectedItemColor:
            Utilities().appColors(context).secondary.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
            ),
            label: "Locations",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit_square,
            ),
            label: "Notes",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_added_sharp,
            ),
            label: "Pins",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_contact_calendar_outlined,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
