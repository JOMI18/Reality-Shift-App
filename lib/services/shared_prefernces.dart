import 'package:reality_shift/imports.dart';

class CustomSharedPreference {
  static SharedPreferences? _prefs;

  CustomSharedPreference() {
    initializePrefs();
  }

  Future<void> initializePrefs() async {
    //   This line of code is ensuring that _prefs is initialized with an instance of SharedPreferences,
    //   but only if _prefs is currently null. If _prefs is already initialized (not null), then SharedPreferences.getInstance()
    //  won't be called, and _prefs will remain unchanged.
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await initializePrefs();

    _prefs!.setString(key, value);
    print("Get $key: $value");
  }

  Future<String?> getString(String key) async {
    await initializePrefs();
    final value = _prefs!.getString(key);
    print("Get $key: $value");
    return value;
  }

  Future<void> remove(String key) async {
    await initializePrefs();
    _prefs!.remove(key);
    print("Removed $key");
  }

  Future<void> clear() async {
    await initializePrefs();
    _prefs!.clear();
    print("Cleared all preferences");
  }
}
