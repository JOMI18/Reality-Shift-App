import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  final List<Widget> bodyWidget = const [
    Home(),
    Continents(),
    Notes(),
    Pins(),
    Profile(),
    Panel()
  ];

  bool isAdmin =
      true; // Assuming isAdmin is a boolean value based on the user's role

  @override
  Widget build(BuildContext context) {
    Color rootcolor = Utilities().appColors(context).secondary;

    // Create a list of default navigation bar items
    List<BottomNavigationBarItem> items = [
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
    ];

    // Conditionally add an additional navigation bar item for admins
    if (isAdmin) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(
            Icons.admin_panel_settings,
          ),
          label: "Admin",
        ),
      );
    }

    return Scaffold(
      body: bodyWidget.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          // if (index >= 0 && index < bodyWidget.length) {
          // Ensure the index is within bounds
          setState(() {
            selectedIndex = index;
          });
          // }
        },
        currentIndex: selectedIndex,
        selectedItemColor: rootcolor,
        unselectedItemColor: rootcolor.withOpacity(0.5),
        items: items, // Use the dynamically generated list of items
      ),
    );
  }
}
