import 'package:coffice_app/screens/landing_screen.dart';
import 'package:coffice_app/screens/splash_screen.dart';
import 'package:coffice_app/services/auth_api.dart';
import 'package:coffice_app/services/data_api.dart';
import 'package:coffice_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => AuthApi());
  GetIt.I.registerLazySingleton(() => DataApi());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee',
      theme: Styles.appTheme,
      home: SplashScreen(),
      routes: {
        LandingScreen.ROUT_NAME: (_) => LandingScreen(),
      },
    );
  }
}
