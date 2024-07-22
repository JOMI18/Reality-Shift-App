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
          // print(selectedTheme);
          return MaterialApp(
            title: 'Reality Shift',
            debugShowCheckedModeBanner: false,
            theme: selectedTheme,
            // initialRoute: "login",
            // initialRoute: "index",
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

              // services
              "forgot_pin": (context) => const ForgotPassword(),
              "about": (context) => const AboutApp(),
              "account_status": (context) => const AccountStatus(),

              // features
              // "all_notes": (context) => const AllNotes(),
              // "notes": (context) => const Notes(),
              "bucket_list": (context) => const BucketList(),

              "notes_pad": (context) => const NotesPad(),
              "folders": (context) => MyFolders(),
              // "new_note": (context) => CreateNewNote(),

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


// Localization
// ask about     isAggregator: 0,
// fix being able to click send again consistently
// allow me to be able to control erasing on verify screen
// handle semantic labels for accessibility
// handle errors for img
// optimize all images
// make admin responsive on web
// validate editing individual user profile
// verify in back end first
// add all notes to continents
// fix search navigation


// Need to do
// 1. Implement Login by Apple and Google
// 2. Auto fill OTP on Paste for Verification Screen
// 3. Figure out Alternative Reset Password Email Verification {using the OG screen}
// 4. Create Notification for Users when API response is Successful
// 5. Configure iOS biometrics
// 6. Setting Profiles to rebuild after its been changed
// 7. Every User will have their on Pin Fav,Notes. e.t.c in the db
// 8. Fix Alert to not take the entire screen
// 9. Before deleting or deactivating verify account
// 10. Handle BucketListProvider state management
// 11. animation for icons
// 12. Handle SharedPreference for NotesProvider




// In production
// 1. check code expiration for 60secs since the queue would be running already