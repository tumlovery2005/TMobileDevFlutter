import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmobiledev/bloc/UserMeBloc.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';
import 'package:tmobiledev/page/LoginPage.dart';
import 'package:tmobiledev/utils/ColorsUtils.dart';
import 'package:tmobiledev/utils/EnterExitRoute.dart';
import 'package:tmobiledev/utils/pref_manager.dart';

import 'MainAppPage.dart';

class SplashPage extends StatefulWidget {

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  double shortTestside;

  @override
  void initState() {
    super.initState();
    Prefs.load();
    Timer(Duration(seconds: 3), () => { _checkData() });
  }

  @override
  Widget build(BuildContext context) {
    shortTestside = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue,
              Colors.green,
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(shortTestside / 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('TmobileDev', style: TextStyle(color: Colors.white,
                    fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _checkData() async {
    String authen = Prefs.getString(Prefs.PREF_AUTHEN);
    if(authen == null){
      _nextPage();
    } else {
      if(authen == ""){
        _nextPage();
      } else {
        _getUserMe(authen);
      }
    }
  }

  _getUserMe(String authen){
    Future<UserStatusModel> userme = userMeBloc.getUserMe(authen);
    userme.then((value) => {
      if(value.error == ""){
        print("data ${value.data}"),
        if(value.status){
          _saveUserme(jsonEncode(value.data.toJson())),
          _nextMainAppPage(),
        } else {
          _nextPage(),
        }
      } else {
        print('userme error : ${value.error}'),
        _nextPage(),
      },
    });
  }

  _saveUserme(String usermeJson){
    Prefs.setString(Prefs.PREF_USER_ME, usermeJson);
  }

  _nextPage() {
    Navigator.pop(context);
    Navigator.push(context, EnterExitRoute(enterPage: LoginPage()));
  }

  _nextMainAppPage() {
    Navigator.pop(context);
    Navigator.push(context, EnterExitRoute(enterPage: MainAppPage()));
  }
}