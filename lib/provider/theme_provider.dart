import 'package:firebase_autentication/shared/preferences.dart';
import 'package:firebase_autentication/themes/styles_settings.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData = temaDia();

  //double _dimenFont = 1;

  //getdimenFont() => this._dimenFont;
  //setdimenFont(double value) {
  //  this._dimenFont = value;
  //  notifyListeners();
  //}

  getthemeData() {
    if (Preference.theme.isNotEmpty) {
      switch (Preference.theme) {
        case 'temaDia':
          _themeData = temaDia();
          break;
        case 'temaNoche':
          _themeData = temaNoche();
          break;
        case 'temaAzul':
          _themeData = temaAzul();
          break;
        case 'temaVerde':
          _themeData = temaVerde();
          break;
        default:
          _themeData = temaDia();
      }
    }
    return _themeData;
  }

  setthemeData(ThemeData theme) {
    _themeData = theme;
    print('tema: ${_themeData!.primaryColor}');
    notifyListeners();
  }
}
