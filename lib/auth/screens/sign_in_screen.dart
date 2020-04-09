import 'package:coffice_app/services/auth_api.dart';
import 'package:coffice_app/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:validators/validators.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  const SignInScreen(this.toggleView);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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

  void _loginUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      dynamic result = await _auth.loginUser(_emailText, _passwordText);
//      setState(() {
//        _isLoading = false;
//      });
      if (result == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(Strings.error_sign_in_message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.sign_in),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(Strings.sign_up),
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
                  RaisedButton(
                      child: Text(
                        Strings.sign_in,
                      ),
                      onPressed: () {
                        _loginUser();
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
                  ? ScreenUtil.screenHeightDp - ScreenUtil().setHeight(100)
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
