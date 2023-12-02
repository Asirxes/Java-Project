import 'package:flutter/material.dart';

const MaterialColor mycolor = MaterialColor(_mycolorPrimaryValue, <int, Color>{
  50: Color(0xFFE8F3F4),
  100: Color(0xFFC5E0E4),
  200: Color(0xFF9ECCD2),
  300: Color(0xFF77B7BF),
  400: Color(0xFF59A7B2),
  500: Color(_mycolorPrimaryValue),
  600: Color(0xFF36909C),
  700: Color(0xFF2E8592),
  800: Color(0xFF277B89),
  900: Color(0xFF1A6A78),
});
const int _mycolorPrimaryValue = 0xFF3C98A4;

MaterialColor mycolorAccent = MaterialColor(_mycolorAccentValue, <int, Color>{
  100: Color(0xFFB2F2FF),
  200: Color(_mycolorAccentValue),
  400: Color(0xFF4CE1FF),
  700: Color(0xFF32DDFF),
});
const int _mycolorAccentValue = 0xFF7FEAFF;
