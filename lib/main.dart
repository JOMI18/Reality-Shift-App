import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Reality Shift',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Acme",
          colorScheme: ColorScheme.fromSeed(
              primary: Color.fromARGB(255, 15, 34, 45),
              secondary: Color.fromARGB(255, 255, 245, 208),
              background: Color(0xFF0F222D),
              seedColor: Color(0xFF0F222D)),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF0F222D)),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Color(0xFF0F222D),
          ),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF0F222D)
              // backgroundColor: Color(0xFFFFF5D0),
              ),
          useMaterial3: true,
        ),
        // initialRoute: "dashboard",
        initialRoute: "dashboard",
        routes: {
          "index": (context) => Index(),
          "onboarding": (context) => Onboarding(),
          "choose_signup": (context) => ChooseSignUp(),
          "signup": (context) => SignUp(),
          "cta": (context) => CTA(),
          "verification": (context) => Verification(),
          "login": (context) => Login(),
          "dashboard": (context) => Dashboard(),
          "signout": (context) => SignOut(),
          "locations": (context) => Locations(),
          "user": (context) => Profile(),
          "favs": (context) => Pins(),
          "notify": (context) => Notify(),

          // admin
          "admin_panel": (context) => Panel(),
          "create_continent": (context) => CreateContinent(),
          "manage_users": (context) => ManageUsers()
        },
      );
    });
  }
}

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
// add url launcher for xe currency