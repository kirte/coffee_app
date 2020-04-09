import 'package:coffice_app/auth/models/user.dart';
import 'package:coffice_app/home/models/coffee.dart';
import 'package:coffice_app/services/auth_api.dart';
import 'package:coffice_app/services/data_api.dart';
import 'package:coffice_app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class UpdateCoffee extends StatefulWidget {
  @override
  _UpdateCoffeeState createState() => _UpdateCoffeeState();
}

class _UpdateCoffeeState extends State<UpdateCoffee> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];
  DataApi _dataApi;
  AuthApi _authApi;

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  void initState() {
    _dataApi = GetIt.I<DataApi>();
    _authApi = GetIt.I<AuthApi>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream:_authApi.user,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.brown[100],
              child: Center(
                child: SpinKitChasingDots(
                  color: Colors.brown,
                  size: ScreenUtil().setHeight(50.0),
                ),
              ),
            );
          }
          User user = snapshot.data;
          return StreamBuilder<Coffee>(
              stream: _dataApi.getUserCoffee(user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Coffee coffee = snapshot.data;
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          Strings.update_coffee_msg,
                          style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(20.0)),
                        TextFormField(
                          initialValue: coffee.name,
                          validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                          onChanged: (val) =>
                              setState(() =>
                              _currentName = val),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10.0)),
                        DropdownButtonFormField(
                          value: _currentSugars ?? coffee.sugars,
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text('$sugar sugars'),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() =>
                              _currentSugars = val),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10.0)),
                        Slider(
                          value: (_currentStrength ?? coffee.strength)
                              .toDouble(),
                          activeColor:
                          Colors.brown[_currentStrength ?? coffee.strength],
                          inactiveColor:
                          Colors.brown[_currentStrength ?? coffee.strength],
                          min: 100.0,
                          max: 900.0,
                          divisions: 8,
                          onChanged: (val) =>
                              setState(() => _currentStrength = val.round()),
                        ),
                        RaisedButton(
                            child: Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await _dataApi.updateCoffee(Coffee(
                                    sugars: _currentSugars ??
                                        snapshot.data.sugars,
                                    name: _currentName ?? snapshot.data.name,
                                    strength:
                                    _currentStrength ?? snapshot.data.strength),
                                    user.uid);
                                Navigator.pop(context);
                              }
                            }),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.brown[100],
                    child: Center(
                      child: SpinKitChasingDots(
                        color: Colors.brown,
                        size: ScreenUtil().setHeight(50.0),
                      ),
                    ),
                  );
                }
              });
        });
  }
}
