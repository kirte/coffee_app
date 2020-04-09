import 'package:coffice_app/auth/models/user.dart';
import 'package:coffice_app/home/models/coffee.dart';
import 'package:coffice_app/home/widgets/coffee_tile.dart';
import 'package:coffice_app/home/widgets/update_coffee.dart';
import 'package:coffice_app/services/auth_api.dart';
import 'package:coffice_app/services/data_api.dart';
import 'package:coffice_app/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthApi _auth;
  DataApi _dataApi;


  void _showSettingsPanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20.0), horizontal: ScreenUtil().setWidth(60)),
        child: UpdateCoffee(),
      );
    });
  }

  @override
  void initState() {
    _dataApi = GetIt.I<DataApi>();
    _auth = GetIt.I<AuthApi>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
//        StreamProvider<User>.value(value: _auth.user),
        StreamProvider<List<Coffee>>.value(value: _dataApi.coffeeList)
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text(Strings.settings),
              onPressed: () {
                _showSettingsPanel();
              },
            ),

            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text(Strings.log_out),
              onPressed: () {
                _auth.signOut();
              },
            ),
          ],
        ),
        body: Consumer<List<Coffee>>(builder: (ctx, coffees, _) {

          return ListView.builder(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            itemCount: (coffees??[]).length,
            itemBuilder: (ctx, index) {
              final coffee = coffees[index];
              return CoffeeTile(coffee);
            },
          );
        }),
      ),
    );
  }
}
