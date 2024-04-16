import 'package:reality_shift/imports.dart';

class CustomSharedPreference {
  static SharedPreferences? _prefs;

  CustomSharedPreference() {
    intitalizePrefs();
  }

  Future<void> intitalizePrefs() async {
    //   This line of code is ensuring that _prefs is initialized with an instance of SharedPreferences,
    //   but only if _prefs is currently null. If _prefs is already initialized (not null), then SharedPreferences.getInstance()
    //  won't be called, and _prefs will remain unchanged.
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await intitalizePrefs();

    _prefs!.setString(key, value);
  }

  String? getString(String key) {
    if (_prefs != null) {
      return _prefs!.getString(key);
    }

    return null;
  }
}
