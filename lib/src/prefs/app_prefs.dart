import 'base_prefs.dart';

class AppPref extends BasePrefs {
  static Future<AppPref> instance() async {
    final _appPref = AppPref();
    await _appPref.init();
    return _appPref;
  }

  String get getToken {
    return getValueForKey(PrefKey.token) ?? '';
  }

  Future<void> setToken(String token) {
    return setValueForKey(PrefKey.token, token);
  }
}

class PrefKey {
  static const String token = 'TOKEN';
}
