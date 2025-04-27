import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_colors.dart';

AppColors? appColor(context) => Theme.of(context).extension<AppColors>();

ThemeData getAppTheme(BuildContext context) {
  return ThemeData(
    extensions: const [
      AppColors(
        background: Color(0xff1A0B2E),
        primary: Color(0xffECDFCC),
        primaryText: Color(0xfffafafa),
        secondaryText: Color(0xff7127BA),
        subText: Color(0xff737373),
        errorText: Color(0xffdb292a),
        buttonColor: Color(0xff3E7B27),
        whiteColor: Color(0xfffafafa),
      ),
    ],
    fontFamily: 'LexendMega',
  );
}