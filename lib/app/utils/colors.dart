// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const DefaultText = Color(0xFF5F6368);
  static const BorderColor = Color(0xFFDFDFDF);
  static const LightGreyColor = Color(0xFFe8f0fe);
  static const TextPrimaryColor = Color(0xFF3B3E42);

  static const AppBackgroundColor = Color(0xff6200ED);
  static const Cardcolor = Color(0xFFE6E6E6);
  static const ContainerIconcenter = Color(0xFFB8B8B8);

  // loginnumbercode
  static const NumberLoginFontCOlor = Color(0xff6D6D6D);
  //static const NumberLoginInputText = Color(oxffA8A8A8);
  static const NumberLoginInputText = Color(0xffA5A5A5);
  static const AppbarIconColor = Color(0xFFD7BDF4);
  static const CircleBgColor = Color(0xFFD9D9D9);
  static const TextColor = Color(0xFFA4A4A4);
  static const MoneyColor = Color(0xFF3A3A3A);
  static const AppMidleIconColor = Color(0xFF60636A);
  static const unPaidColor = Color(0xFFE0D4FB);
  static const blackcolor = Color(0xff000000);
  static const partyname = Color(0xffD0D0D0);
  static const partyColor = Color(0xff424242);

  static const MaterialColor PrimaryColor =
      MaterialColor(_primary, <int, Color>{
    50: Color(0xFFE2F2FF),
    100: Color(0xFFBADDFF),
    200: Color(0xFF8CC9FF),
    300: Color(0xFF58B3FF),
    400: Color(0xFF2BA3FF),
    500: Color(0xFF0092FF),
    600: Color(_primary),
    700: Color(0xFF1271EB),
    800: Color(0xFF185FD8),
    900: Color(0xFF1E3EB9),
  });
  static const int _primary = 0xFF6200ED;

  //C107;

  static const MaterialColor SecondaryColor =
      MaterialColor(_secondary, <int, Color>{
    50: Color(0xFFFFF8E0),
    100: Color(0xFFFFEDB0),
    200: Color(0xFFFFE17C),
    300: Color(0xFFFFD743),
    400: Color(_secondary),
    500: Color(0xFFFFC300),
    600: Color(0xFFFFB500),
    700: Color(0xFFFFA100),
    800: Color(0xFFFF8F00),
    900: Color(0xFFFF6D00),
  });
  static const int _secondary = 0xFFFFCC00; //C107;

  static const MaterialColor TriadicColor =
      MaterialColor(_triadic, <int, Color>{
    50: Color(0xFFFFEBEF),
    100: Color(0xFFFFCCD4),
    200: Color(0xFFFE969c),
    300: Color(0xFFF96B74),
    400: Color(0xFFFF3F50),
    500: Color(0xFFFF1A32),
    600: Color(_triadic),
    700: Color(0xFFED002D),
    800: Color(0xFFE00025),
    900: Color(0xFFD30016),
  });
  static const int _triadic = 0xFFFF0033;
}
