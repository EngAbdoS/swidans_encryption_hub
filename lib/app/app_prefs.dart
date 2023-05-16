import 'package:flu_proj/presentation/resourses/langauge_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const USER_ID_KEY = "USER_ID_KEY";
const HISTORY_EN = "HISTORY_EN";
const HISTORY_DE = "HISTORY_DE";
const HISTORY_KEY = "HISTORY_KEY";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
 final List<String>encode=[];
 final List<String>decode=[];
 final List<String>key=[];

  late List<List<String>> _history=[encode,decode,key];

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLangauge() async {
    String? langauge = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (langauge != null && langauge.isNotEmpty) {
      return langauge;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLangauge();
    if (currentLang == LanguageType.ARAIC.getValue()) {
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ARAIC.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLang = await getAppLangauge();
    if (currentLang == LanguageType.ARAIC.getValue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }

  //login screen

  Future<void> setLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  void setUserID(String uID) async {
    _sharedPreferences.setString(USER_ID_KEY, uID);
    print("uid saved");
    print(uID);
  }

  Future addToHistory(String encoded, String decoded, String key) async {
    _history = await getHistory();
    _history[0].add(encoded);
    _history[1].add(decoded);
    _history[2].add(key);
    _sharedPreferences.setStringList(HISTORY_EN, _history[0]);
    _sharedPreferences.setStringList(HISTORY_DE, _history[1]);
    _sharedPreferences.setStringList(HISTORY_KEY, _history[2]);
    print(_sharedPreferences.getStringList(HISTORY_EN));
    print(_sharedPreferences.getStringList(HISTORY_DE));
    print(_sharedPreferences.getStringList(HISTORY_KEY));
  }

  Future removeFromHistory(int index) async {
    _history = await getHistory();
    _history[0].removeAt(index);
    _history[1].removeAt(index);
    _history[2].removeAt(index);
    _sharedPreferences.setStringList(HISTORY_EN, _history[0]);
    _sharedPreferences.setStringList(HISTORY_DE, _history[1]);
    _sharedPreferences.setStringList(HISTORY_KEY, _history[2]);

  }

  Future<List<List<String>>> getHistory() async {
   //_history = [];
    if (_sharedPreferences.containsKey(HISTORY_EN) &&
        _sharedPreferences.containsKey(HISTORY_DE) &&
        _sharedPreferences.containsKey(HISTORY_KEY)) {
      List<String>? encoded =
          await _sharedPreferences.getStringList(HISTORY_EN);
      List<String>? decoded =
          await _sharedPreferences.getStringList(HISTORY_DE);
      List<String>? key = await _sharedPreferences.getStringList(HISTORY_KEY);
      print(encoded);
     // _history = [];
      _history.add(encoded ?? []);
      _history.add(decoded ?? []);
      _history.add(key ?? []);

    }
    print("in pref");
    print( _sharedPreferences.getStringList(HISTORY_EN));
    return _history;
  }

  Future<String> getUserID() async {
    String id = _sharedPreferences.getString(USER_ID_KEY) ?? "";
    return id;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
    _sharedPreferences.remove(USER_ID_KEY);
  }
}
