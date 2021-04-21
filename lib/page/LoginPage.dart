import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tmobiledev/bloc/LoginBloc.dart';
import 'package:tmobiledev/bloc/UserMeBloc.dart';
import 'package:tmobiledev/model/StatusModel.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';
import 'package:tmobiledev/page/MainAppPage.dart';
import 'package:tmobiledev/utils/EnterExitRoute.dart';
import 'package:tmobiledev/utils/pref_manager.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  double shortTestside;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = true;
  bool loading = false;

  @override
  void initState() {
    Prefs.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    shortTestside = MediaQuery.of(context).size.shortestSide;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: ModalProgressHUD(
          child: Container(
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
                    _boxInputEmail(),
                    _boxInputPassword(),
                    _buttonLogin(),
                  ],
                ),
              ),
            ),
          ),
          inAsyncCall: loading,
        ),
      ),
    );
  }

  Widget _boxInputEmail(){
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: shortTestside /10),
        child: Card(
            shadowColor: Colors.lightBlue,
            elevation: 3.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(shortTestside / 10)),
            child: Container(
              padding: EdgeInsets.all(shortTestside / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(shortTestside / 100),
                    child: Icon(Icons.email, color: Colors.lightBlue),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: shortTestside / 100),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "E-mail",
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }

  Widget _boxInputPassword(){
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: shortTestside / 100),
        child: Card(
            shadowColor: Colors.lightBlue,
            elevation: 3.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(shortTestside / 10)),
            child: Container(
              padding: EdgeInsets.all(shortTestside / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(shortTestside / 100),
                    child: Icon(Icons.vpn_key, color: Colors.lightBlue),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: shortTestside / 100),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: InputBorder.none,
                        ),
                        enableSuggestions: false,
                        obscureText: showPassword,
                        maxLines: 1,
                      ),
                    )
                  ),
                  InkResponse(
                    child: Container(
                      margin: EdgeInsets.all(shortTestside / 100),
                      child: _iconShowPassword(),
                    ),
                    onTap: () => {
                      if(showPassword){
                        _setShowPassword(false),
                      } else {
                        _setShowPassword(true),
                      }
                    },
                  ),
                ],
              ),
            )
        )
    );
  }

  Widget _iconShowPassword(){
    if(showPassword){
      return Icon(Icons.visibility_off_sharp, color: Colors.lightBlue);
    } else {
      return Icon(Icons.remove_red_eye_sharp, color: Colors.lightBlue);
    }
  }

  Widget _buttonLogin(){
    return Container(
      margin: EdgeInsets.all(shortTestside / 100),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {
          _setLoading(true),
          _LoginRequest(),
        },
        child: Text('Login', style: TextStyle(color: Colors.white),),
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)
        ),
      ),
    );
  }

  _LoginRequest(){
    String email = _emailController.text.toString().trim();
    String password = _passwordController.text.toString().trim();
    Future<StatusModel> login = loginBloc.login(email, password);
    String authen = 'Basic ' + base64Encode(utf8.encode('${email}:${password}'));
    login.then((value) => {
      if(value.error == ""){
        if(value.status){
          _saveAuthen(authen),
          _getUserMe(authen),
        } else {
          print('error model : ${value.messge}'),
          _setLoading(false),
        }
      } else {
        print('error model : ${value.error}'),
        _setLoading(false),
      },
    });
  }

  _getUserMe(String authen){
    Future<UserStatusModel> userme = userMeBloc.getUserMe(authen);
    userme.then((value) => {
      if(value.error == ""){
        if(value.status){
          _saveUserme(jsonEncode(value.data.toJson())),
          _nextMainAppPage(),
        } else {
          print('error status message : ${value.messge}')
        }
      } else {
        print('userme error : ${value.error}'),
      },
      _setLoading(false),
    });
  }

  _saveAuthen(String email){
    Prefs.setString(Prefs.PREF_AUTHEN, email);
  }

  _saveUserme(String usermeJson){
    Prefs.setString(Prefs.PREF_USER_ME, usermeJson);
  }

  _setLoading(bool _loading){
    setState(() {
      loading = _loading;
    });
  }

  _setShowPassword(bool _isShow){
    setState(() {
      showPassword = _isShow;
    });
  }

  _nextMainAppPage() {
    Navigator.pop(context);
    Navigator.push(context, EnterExitRoute(enterPage: MainAppPage()));
  }
}