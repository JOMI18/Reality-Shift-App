import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

void main() {
  runApp(const MyApp());
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
        initialRoute: "index",
        routes: {
          "index": (context) => Index(),
          "onboarding": (context) => Onboarding(),
          "choose_signup": (context) => ChooseSignUp(),
          "signup": (context) => SignUp(),
          "cta": (context) => CTA(),
          "verification": (context) => Verification(),
          "login": (context) => Login(),
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
