import 'package:flutter/material.dart';
import 'package:reality_shift/imports.dart';

class AppThemeMode extends StatefulWidget {
  const AppThemeMode({super.key});

  @override
  State<AppThemeMode> createState() => _AppThemeModeState();
}

class _AppThemeModeState extends State<AppThemeMode>
    with AutomaticKeepAliveClientMixin {
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

  void _setAutomatic(WidgetRef ref) {
    if (isSwitchOnNow) {
      final currentTime = DateTime.now();
      final isDayTime = currentTime.hour >= 6 && currentTime.hour < 18;
      final newTheme = isDayTime ? lightTheme : darkTheme;
      setState(() {
        selectedMode = isDayTime ? "light" : "dark";
      });
      ref.read(AppThemeProvider.notifier).state = {"theme": newTheme};
    }

    if (!isSwitchOnNow) {
      final newTheme = darkTheme;
      setState(() {
        selectedMode = "dark";
      });
      ref.read(AppThemeProvider.notifier).state = {"theme": newTheme};
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _loadSelectedMode(); // Load selected mode when the widget is initialized
  // }

  // // Load selected mode from SharedPreferences
  // void _loadSelectedMode() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     selectedMode = prefs.getString('selectedMode') ?? "dark";
  //   });
  // }

  // // Save selected mode to SharedPreferences
  // void _saveSelectedMode(String mode) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('selectedMode', mode);
  // }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Call super build method to ensure state is kept alive

    return Scaffold(
      appBar: CustomAppBar().generalbar(context, "Display & Theme"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer(
          builder: (context, ref, child) {
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
                                    },
                                  ),
                                  Text(
                                    mode.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  )
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
                              Text(
                                "Automatic",
                                style: TextStyle(color: Colors.white),
                              ),
                              CustomSwitch.buildSwitch(
                                context,
                                isSwitchOn: isSwitchOnNow,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitchOnNow = value;
                                    _setAutomatic(ref);
                                    selectedMode;
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

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive to return true
}
