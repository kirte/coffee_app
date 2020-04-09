import 'package:coffice_app/auth/models/user.dart';
import 'package:coffice_app/home/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee _coffee;

  const CoffeeTile(this._coffee);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setHeight(10)),
      child: ListTile(
        leading: CircleAvatar(
          radius: ScreenUtil().setHeight(25),
          backgroundColor: Colors.brown[_coffee.strength],
          backgroundImage: AssetImage('assets/images/coffee_icon.png'),
        ),
        title: Text(_coffee.name),
        subtitle: Text('Takes ${_coffee.sugars} sugar(s)'),
      ),
    );
    ;
  }
}
