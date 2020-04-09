import 'package:coffice_app/services/auth_api.dart';
import 'package:coffice_app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:validators/validators.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;

  const SignUpScreen(this.toggleView);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthApi _auth;

  // text field state
  String _emailText = '';
  String _passwordText = '';

  @override
  void initState() {
    _auth = GetIt.I<AuthApi>();
    super.initState();
  }

  void _signUpUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      dynamic result = await _auth.signUpUser(_emailText, _passwordText);
      setState(() {
        _isLoading = false;
      });
      if (result == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(Strings.error_sign_up_message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(
              ScreenUtil().setHeight(20),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setHeight(20),
                      ),
                      hintText: Strings.enter_your_email,
                    ),
                    validator: (value) {
                      if (!isEmail(value.trim())) {
                        return Strings.error_valid_email;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _emailText = value.trim();
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20.0)),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setHeight(20),
                      ),
                      hintText: Strings.enter_your_password,
                    ),
                    validator: (value) {
                      if (value.trim().length < 6) {
                        return Strings.error_valid_password;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _passwordText = value.trim();
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20.0)),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setHeight(20),
                      ),
                      hintText: Strings.enter_your_confirm_password,
                    ),
                    validator: (value) {
                      if (value.trim().length < 6) {
                        return Strings.error_valid_confirm_password;
                      }
                      if (value.trim() == _passwordText) {
                        return Strings.error_valid_confirm_mismatch;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20.0)),
                  RaisedButton(
//                  color: Colors.pink[400],
                      child: Text(
                        Strings.sign_in,
                      ),
                      onPressed: () {
                        _signUpUser();
                      }),
                ],
              ),
            ),
          ),
          Center(
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 6.0),
                      blurRadius: 6.0)
                ],
              ),
              duration: Duration(milliseconds: 300),
              width: _isLoading
                  ? ScreenUtil.screenWidthDp - ScreenUtil().setWidth(100)
                  : 0,
              height: _isLoading
                  ? ScreenUtil.screenHeightDp - ScreenUtil().setHeight(200)
                  : 0,
              alignment: Alignment.center,
              child: SpinKitChasingDots(
                color: Colors.brown,
                size: ScreenUtil().setHeight(50),
              ),
            ),
          )
        ],
      ),
    );
  }
}
