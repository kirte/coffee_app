import 'package:coffice_app/auth/models/user.dart';
import 'package:coffice_app/auth/screens/auth_wrapper.dart';
import 'package:coffice_app/home/screens/home.dart';
import 'package:coffice_app/services/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'loadingScreen.dart';

class LandingScreen extends StatelessWidget {
  static const String ROUT_NAME = "/landingScreen";
  final _auth = GetIt.I<AuthApi>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: _auth.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        User user = snapshot.data;
        if (user == null) {
          return AuthWrapper();
        } else {
          return HomeScreen();
        }
      },
    );
  }
}
