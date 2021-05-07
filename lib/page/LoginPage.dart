import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tmobiledev/bloc/LoginBloc.dart';
import 'package:tmobiledev/bloc/UserMeBloc.dart';
import 'package:tmobiledev/model/StatusModel.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';
import 'package:tmobiledev/page/MainAppPage.dart';
import 'package:tmobiledev/page/RegisterPage.dart';
import 'package:tmobiledev/utils/DialogUtils.dart';
import 'package:tmobiledev/utils/EnterExitRoute.dart';
import 'package:tmobiledev/utils/pref_manager.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  double shortTestside;
  double shortWidthsize;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = true;
  bool loading = false;

  List<String> listValue = [
    "อีเมล์", "รหัสผ่าน"
  ];

  @override
  void initState() {
    Prefs.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    shortTestside = MediaQuery.of(context).size.shortestSide;
    shortWidthsize = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait){
      return _isPortrait();
    } else {
      return _isLandscape();
    }
  }

  Widget _isPortrait(){
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
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
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(top: shortWidthsize / 5),
              child: ModalProgressHUD(
                child: Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage('assets/title_image.png'),
                              width: shortWidthsize / 2, color: Colors.white,
                            ),
                          ),
                          Text('TmobileDev', style: TextStyle(color: Colors.white,
                              fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                          ),
                          _layoutLogin()
                        ],
                      ),
                    )
                ),
                inAsyncCall: loading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _isLandscape(){
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
        child: Row(
          children: <Widget>[
            Container(
              width: (shortWidthsize / 2),
              height: double.infinity,
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image(
                      image: AssetImage('assets/title_image.png'),
                      width: shortWidthsize / 4, color: Colors.white,
                    ),
                  ),
                  Text('TmobileDev', style: TextStyle(color: Colors.white,
                      fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            ),
            Expanded(
              child: _layoutLogin(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _layoutLogin(){
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(shortTestside / 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Login', style: TextStyle(color: Colors.white,
                    fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                ),
                _boxInputEmail(),
                _boxInputPassword(),
                _buttonLogin(),
                _ButtonRegister(),
              ],
            ),
          ),
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
        child: Text('Login', style: TextStyle(color: Colors.white)),
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)
        ),
      ),
    );
  }

  Widget _ButtonRegister(){
    return Container(
      margin: EdgeInsets.all(shortTestside / 100),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {
          _validateLogin(),
        },
        child: Text('Register', style: TextStyle(color: Colors.white)),
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)
        ),
      ),
    );
  }

  _validateLogin(){
    String email = _emailController.text.toString().trim();
    String password = _passwordController.text.toString().trim();
    List<String> inputValue = [];
    List<String> checkValue = [];
    inputValue.add(email);
    inputValue.add(password);
    if(!email.isEmpty && !password.isEmpty){
      _LoginRequest(email, password);
    } else {
      DialogUtils().showDialogMessage(context, "คำเตือน", "กรุณากรอกข้อมูลให้ครบทุกช่อง");
    }
  }

  _LoginRequest(String email, String password){
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

  _saveAuthen(String authen){
    Prefs.setString(Prefs.PREF_AUTHEN, authen);
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

  _nextRegisterPage() {
    Navigator.push(context, EnterExitRoute(enterPage: RegisterPage()));
  }

  _nextMainAppPage() {
    Navigator.pop(context);
    Navigator.push(context, EnterExitRoute(enterPage: MainAppPage()));
  }
}