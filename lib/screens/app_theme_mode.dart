import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';
import 'package:reality_shift/main.dart';

class AppThemeMode extends StatefulWidget {
  const AppThemeMode({super.key});

  @override
  State<AppThemeMode> createState() => _AppThemeModeState();
}

class _AppThemeModeState extends State<AppThemeMode> {
  List modes = [
    {"mode": "dark", "img": "darkmode.png"},
    {"mode": "light", "img": "lightmode.png"},
  ];
  late bool isSwitchOnNow = false;

  String selectedMode = "dark"; // Default selected mode is "dark"

  void _toggleTheme(WidgetRef ref) {
    final themeMap = ref.read(AppThemeProvider.notifier).state;
    // print("Current Theme: $themeMap");
    // print("Dark Theme: $darkTheme");
    final newTheme = themeMap["theme"] == darkTheme ? lightTheme : darkTheme;
    // print("New Theme: $newTheme");
    ref.read(AppThemeProvider.notifier).state = {"theme": newTheme};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Display & Theme"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer(
          builder: (context, ref, child) {
            // final selectedTheme = ref.watch(AppThemeProvider)["theme"];
            // print(selectedTheme);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Appearance:"),
                SizedBox(height: 1.h),
                Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.teal,
                  ),
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: modes.map((modeEl) {
                              final mode = modeEl["mode"]!;
                              final img = modeEl["img"]!;
                              final isSelected = mode == selectedMode;
                              return Column(
                                children: [
                                  Image.asset(
                                    "lib/assets/images/theme/$img",
                                    height: 40.h,
                                    width: 45.w,
                                  ),
                                  Checkbox(
                                    value: isSelected,
                                    onChanged: (newValue) {
                                      if (!isSelected) {
                                        setState(() {
                                          _toggleTheme(ref);
                                          selectedMode = mode;
                                        });
                                      }
                                      // setState(() {
                                      //   _toggleTheme(ref);
                                      //   selectedMode =
                                      //       mode; // Update selected mode
                                      // });
                                    },
                                  ),
                                  Text(mode.toUpperCase())
                                ],
                              );
                            }).toList()),
                        Divider(
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 16, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Automatic"),
                              CustomSwitch.buildSwitch(
                                context,
                                isSwitchOn: isSwitchOnNow,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitchOnNow = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


// Container(
//   color: selectedTheme == darkTheme ? Colors.black : Colors.white,
//   child: Text(
//     "This text has different color based on the selected theme",
//     style: TextStyle(
//       color: selectedTheme == darkTheme ? Colors.white : Colors.black,
//     ),
//   ),
// )