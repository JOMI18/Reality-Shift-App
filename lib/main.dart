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
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Acme",
          colorScheme: ColorScheme.fromSeed(
              primary: const Color.fromARGB(255, 15, 34, 45),
              secondary: const Color.fromARGB(255, 255, 245, 208),
              background: const Color.fromARGB(255, 15, 34, 45),
              seedColor: const Color.fromARGB(255, 15, 34, 45)),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFFFFF5D0),
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Color(0xFFFFF5D0),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFFF5D0),
          ),
          useMaterial3: true,
        ),
        initialRoute: "index",
        routes: {
          "index": (context) => Index(),
          "onboarding": (context) => Onboarding(),
          "signup": (context) => SignUp(),
          "cta": (context) => CTA(),
        },
      );
    });
  }
}

// world time api 
// https://worldtimeapi.org/api/timezone/