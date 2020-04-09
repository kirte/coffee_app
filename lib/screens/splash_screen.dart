import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'landing_screen.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed(LandingScreen.ROUT_NAME));
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset('assets/images/tea.png',height: ScreenUtil().setHeight(200),),
        ),
      ),
    );
  }
}
