import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Consumer(
        builder: (context, ref, child) {
          final selectedTheme = ref.watch(AppThemeProvider)["theme"];
          print(selectedTheme);
          return MaterialApp(
            title: 'Reality Shift',
            debugShowCheckedModeBanner: false,
            theme: selectedTheme,
            // initialRoute: "dashboard",
            initialRoute: "dashboard",
            routes: {
              "index": (context) => const Index(),
              "onboarding": (context) => const Onboarding(),
              "choose_signup": (context) => ChooseSignUp(),
              "signup": (context) => const SignUp(),
              "cta": (context) => const CTA(),
              "verification": (context) => const Verification(),
              "login": (context) => const Login(),

              // user
              "dashboard": (context) => const Dashboard(),
              "signout": (context) => const SignOut(),
              "locations": (context) => const Locations(),
              "user": (context) => const Profile(),
              "favs": (context) => const Pins(),
              "notify": (context) => const Notify(),
              "full_user_profile": (context) => const FullUserProfile(),
              "app_theme": (context) => const AppThemeMode(),

              // notes
              "all_notes": (context) => const AllNotes(),

              // admin
              "admin_panel": (context) => const Panel(),
              "create_continent": (context) => const CreateContinent(),
              "manage_users": (context) => const ManageUsers()
            },
          );
        },
      );
    });
  }
}

final lightTheme = ThemeData(
  fontFamily: "Acme",
  colorScheme: ColorScheme.fromSeed(
    primary: const Color.fromARGB(255, 255, 245, 208),
    secondary: const Color.fromARGB(255, 15, 34, 45),
    background: const Color.fromARGB(255, 255, 245, 208),
    seedColor: const Color.fromARGB(255, 255, 245, 208),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
  ),
  
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: Color(0xFFFFF5D0)),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFFFFF5D0),
  ),
  appBarTheme: const AppBarTheme(
    foregroundColor: Color.fromARGB(255, 15, 34, 45),
    backgroundColor: Color(0xFFFFF5D0),
  ),
  // cardTheme: const CardTheme(color: Colors.black),
  // dividerColor: Colors.black,
  // listTileTheme: const ListTileThemeData(
  //     subtitleTextStyle: TextStyle(color: Colors.white),
  //     titleTextStyle: TextStyle(color: Colors.white)),
  useMaterial3: true,
);

final darkTheme = ThemeData(
  fontFamily: "Acme",
  colorScheme: ColorScheme.fromSeed(
      primary: const Color.fromARGB(255, 15, 34, 45),
      secondary: const Color.fromARGB(255, 255, 245, 208),
      background: const Color(0xFF0F222D),
      seedColor: const Color(0xFF0F222D)),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
  ),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: Color(0xFF0F222D)),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFF0F222D),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0F222D),
    foregroundColor: Color(0xFFFFF5D0),
  ),
  dividerColor: Colors.white,
  useMaterial3: true,
);

// world time api 
// https://worldtimeapi.org/api/timezone/
// build backend api
  // configure apple and google sign in properly

// Localization
// ask about     isAggregator: 0,
// log in
// handle setting tokens to prevent reviewing screens when set
// fix being able to click send again consistently
// add user provider to get access to first name on login page
// allow me to be able to control erasing on verify screen
// handle semantic labels for accessibility
// handle errors for img
// add confetti on successful signup
// make admin responsive
//check if main users table haas img 
// optimize all images
// validate editing user profile
// verify in back end first
// add all notes to continents