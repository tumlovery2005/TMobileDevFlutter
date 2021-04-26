import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tmobiledev/bloc/UserMeBloc.dart';
import 'package:tmobiledev/model/user/UserModel.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';
import 'package:tmobiledev/utils/ImageProfileFailUtils.dart';
import 'package:tmobiledev/utils/pref_manager.dart';

class ProfilePage extends StatefulWidget {

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  double shortTestside;
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
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 3.0,
        title: Text('โปรไฟล์', style: TextStyle(color: Colors.white,
            fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: ModalProgressHUD(
        child: SafeArea(
          child: Opacity(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(shortTestside / 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  getIconProfile(""),
                  _text("${userModel.checkin_user_name}",Alignment.center, Colors.black),
                  _text("เบอร์โทรศัพท์ : ${userModel.checkin_user_telephone}", Alignment.center, Colors.black),
                  _text("อีเมล : ${userModel.checkin_user_email}",  Alignment.center, Colors.black),
                  _text("วันเดือนปี เกิด : ${userModel.checkin_user_birth_date}",  Alignment.center, Colors.black),
                  _text("ที่อยู่ : ${userModel.checkin_user_address}",Alignment.topLeft, Colors.black),
                ],
              ),
            ),
            opacity: showOpacity,
          ),
        ),
        inAsyncCall: loading,
      ),
    );
  }

  Widget getIconProfile(String photo) {
    return Container(
      width: shortTestside / 4,
      height: shortTestside / 4,
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(100),
        child: Container(
          color: Colors.grey,
          child: photo != "" ? CachedNetworkImage(
            imageUrl: photo,
            placeholder: (context, url) => ImageProfileFailUtils().imageFail(shortTestside / 4),
            errorWidget: (context, url, error) => ImageProfileFailUtils().imageFail(shortTestside / 4),
            fit: BoxFit.cover,
          ) : ImageProfileFailUtils().imageFail(shortTestside / 4),
        ),
      ),
    );
  }

  Widget _text(String value, Alignment alignment, Color color){
    return Container(
      width: double.infinity,
      alignment: alignment,
      margin: EdgeInsets.all(shortTestside / 20),
      child: Text(value,
          style: TextStyle(color: color, fontSize: shortTestside / 20)
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