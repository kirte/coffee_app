import 'package:coffice_app/auth/screens/sign_in_screen.dart';
import 'package:coffice_app/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _shouldSign = true;
  void _toggleView(){
    setState(() => _shouldSign = !_shouldSign);
  }
  @override
  Widget build(BuildContext context) {
    return _shouldSign?SignInScreen(_toggleView):SignUpScreen(_toggleView);
  }
}
