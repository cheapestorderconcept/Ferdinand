import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelector extends ChangeNotifier {
  void setLocale(bool isGerman) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isGerman", isGerman);
  }
}
