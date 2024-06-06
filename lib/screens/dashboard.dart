import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;
  bool isAdmin = false;

  final List<Widget> bodyWidget = const [
    Home(),
    Continents(),
    Notes(),
    Pins(),
    Profile(),
    Panel()
  ];

  @override
  Widget build(BuildContext context) {
    Color secondary = Utilities().appColors(context).secondary;

    return Consumer(builder: (context, ref, _) {
      final userRole = ref.watch(userProvider.notifier).state.role;

      // print(userRole);

      // Determine if the user is an admin
      bool isAdmin = userRole == "admin";

      List<BottomNavigationBarItem> items = [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "Home",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.location_on,
          ),
          label: "Locations",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.edit_square,
          ),
          label: "Notes",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark_added_sharp,
          ),
          label: "Pins",
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.perm_contact_calendar_outlined,
          ),
          label: "Profile",
        ),
      ];

      // Conditionally add an additional navigation bar item for admins
      if (isAdmin) {
        items.add(
          const BottomNavigationBarItem(
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
          selectedItemColor: secondary,
          unselectedItemColor: secondary.withOpacity(0.5),
          items: items, // Use the dynamically generated list of items
        ),
      );
    });
    // Create a list of default navigation bar items
  }
}
