import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_colors.dart';

AppColors? appColor(context) => Theme.of(context).extension<AppColors>();

ThemeData getAppTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff0B0819),
    extensions: const [
      AppColors(
        background: Color(0xff0B0819),
        primary: Color(0xffECDFCC),
        primaryText: Color(0xffF8FAFC),
        secondaryText: Color(0xffA855F7),
        subText: Color(0xff94A3B8),
        errorText: Color(0xffEF4444),
        buttonColor: Color(0xff7C3AED),
        whiteColor: Color(0xffFFFFFF),
        hoverColor: Color(0xff8B5CF6),
        cardBackground: Color(0x0CFFFFFF),
        cardBorder: Color(0x1FFFFFFF),
        accentColor: Color(0xff06B6D4),
        surfaceColor: Color(0x151E1B4B),
      ),
    ],
    fontFamily: 'Manrope',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Manrope'),
      bodyMedium: TextStyle(fontFamily: 'Manrope'),
      titleLarge: TextStyle(fontFamily: 'Manrope'),
    ),
  );
}
