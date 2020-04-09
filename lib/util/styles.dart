import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import './app_colors.dart';

class Styles {
  Styles._();

  static final ThemeData appTheme = ThemeData(
      primarySwatch: AppColors.primarySwatch,
      accentColor: AppColors.accentColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.brown[100],
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.brown[300],
      ),
      primaryTextTheme: TextTheme(
          title: TextStyle(
        color: AppColors.primarySwatch,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w600,
        height: 1.2,
      )),
      primaryIconTheme: IconThemeData(
        color: AppColors.primarySwatch,
      ));

  static final TextTheme appTextTheme = TextTheme(
    title: titleTextStyle,
    subtitle: subtitleStyle,
  );

  static final titleTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'OpenSans',
    fontSize: ScreenUtil().setSp(22),
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static final subtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: ScreenUtil().setSp(18.0),
    fontFamily: 'OpenSans',
  );


}
