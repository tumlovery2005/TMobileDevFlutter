import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tmobiledev/bloc/UserMeBloc.dart';
import 'package:tmobiledev/model/user/UserModel.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';
import 'package:tmobiledev/page/profile/ProfileEditPage.dart';
import 'package:tmobiledev/utils/DateTimeUtils.dart';
import 'package:tmobiledev/utils/EnterExitRoute.dart';
import 'package:tmobiledev/utils/ImageProfileFailUtils.dart';
import 'package:tmobiledev/utils/StringUtils.dart';
import 'package:tmobiledev/utils/pref_manager.dart';

class ProfilePage extends StatefulWidget {

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  double shortTestside, shortWidthsize, textSize;
  double showOpacity = 0.0;
  bool loading = false;

  UserModel userModel = new UserModel();

  @override
  void initState() {
    Prefs.load();
    _getUserMe(Prefs.getString(Prefs.PREF_AUTHEN));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    shortTestside = MediaQuery.of(context).size.shortestSide;
    shortWidthsize = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
   if(shortTestside < 600){
     textSize = shortTestside / 25;
   } else {
     textSize = shortTestside / 30;
   }
    if(isPortrait){
      return _isPortrait();
    } else {
      return _isLandscape();
    }
  }

  Widget _isPortrait(){
    return Scaffold(
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
          ModalProgressHUD(
            child: SafeArea(
              child: Opacity(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: shortWidthsize / 5,
                    left: shortTestside / 25,
                    right: shortTestside / 25,
                  ),
                  child: Column(
                    children: <Widget>[
                      _LayoutHeader(shortWidthsize / 2),
                      _LayoutProfile(shortTestside / 6),
                    ],
                  ),
                ),
                opacity: showOpacity,
              ),
            ),
            inAsyncCall: loading,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: shortWidthsize / 20),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: shortWidthsize / 13,
              ),
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _ButtonEditProfile(),
    );
  }

  Widget _isLandscape(){
    return Scaffold(
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
          ModalProgressHUD(
            child: SafeArea(
              child: Opacity(
                child: Container(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Container(
                          margin: EdgeInsets.only(
                            top: shortTestside / 25,
                            left: shortTestside / 25,
                            right: shortTestside / 25,
                          ),
                          child: _LayoutProfile(shortTestside / 6),
                        ),
                      ),
                    ],
                  ),
                ),
                opacity: showOpacity,
              ),
            ),
            inAsyncCall: loading,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: shortWidthsize / 40),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: shortWidthsize / 25,
              ),
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _ButtonEditProfile(),
    );
  }

  Widget _ButtonEditProfile(){
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context, EnterExitRoute(enterPage: ProfileEditPage()));
      },
      label: Text('แก้ไขโปรไฟล์', style: TextStyle(fontSize: textSize,
          fontWeight: FontWeight.bold)),
      icon: Icon(Icons.edit, size: textSize),
      backgroundColor: Colors.lightBlue,
    );
  }

  Widget _LayoutHeader(double width){
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage('assets/title_image.png'),
              width: width, color: Colors.white,
            ),
          ),
          Text('TmobileDev', style: TextStyle(color: Colors.white,
              fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }

  Widget _LayoutProfile(double width){
    return SizedBox(
      child: Card(
        elevation: 2.0,
        shadowColor: Colors.lightBlue,
        child: Padding(
          padding: EdgeInsets.all(shortTestside / 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(userModel.checkin_user_email != null) Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getIconProfile(userModel.checkin_user_photo, width),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _text('ชื่อ : ${StringUtils().checkValue(userModel.checkin_user_name)}',
                            Alignment.topLeft, Colors.black),
                        _text('เบอร์โทรศัพท์ : ${StringUtils().checkValue(userModel.checkin_user_telephone)}',
                            Alignment.topLeft, Colors.black),
                        _text('วันเกิด : ${DateTimeUtils().getDateString(userModel.checkin_user_birth_date)}',
                            Alignment.topLeft, Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: shortTestside / 30),
              ),
              if(userModel.checkin_user_email != null) _text('อีเมล์ : '
                  '${StringUtils().checkValue(userModel.checkin_user_email)}',
                  Alignment.topLeft, Colors.black),
              if(userModel.checkin_user_address != null) _text('ที่อยู่ : '
                  '${StringUtils().checkValue(userModel.checkin_user_address)}',
                  Alignment.topLeft, Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget getIconProfile(String photo, double width) {
    return Container(
      width: width,
      height: width,
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(100),
        child: Container(
          color: Colors.grey,
          child: photo != "" ? CachedNetworkImage(
            imageUrl: photo,
            placeholder: (context, url) => ImageProfileFailUtils().imageFail(width),
            errorWidget: (context, url, error) => ImageProfileFailUtils().imageFail(width),
            fit: BoxFit.cover,
          ) : ImageProfileFailUtils().imageFail(width),
        ),
      ),
    );
  }

  Widget _text(String value, Alignment alignment, Color color){
    return Container(
      width: double.infinity,
      alignment: alignment,
      margin: EdgeInsets.only(left: shortTestside / 30, right: shortTestside / 30),
      child: Text(value, style: TextStyle(color: color, fontSize: textSize)
      ),
    );
  }

  _getUserMe(String authen){
    setLoading(true);
    Future<UserStatusModel> userme = userMeBloc.getUserMe(authen);
    userme.then((value) => {
      if(value.error == ""){
        print("data ${value.data}"),
        if(value.status){
          setUserModel(value.data),
          setShowOpacity(1.0),
        } else {

        }
      } else {
        print('userme error : ${value.error}'),
      },
      setLoading(false),
    });
  }

  setUserModel(UserModel _userModel){
    setState(() {
      userModel = _userModel;
    });
  }

  setLoading(bool _loading){
    setState(() {
      loading = _loading;
    });
  }

  setShowOpacity(double _showOpacity){
    setState(() {
      showOpacity = _showOpacity;
    });
  }
}