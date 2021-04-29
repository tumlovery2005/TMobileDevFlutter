import 'dart:convert';

import 'package:action_broadcast/action_broadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tmobiledev/bloc/RegisterBloc.dart';
import 'package:tmobiledev/bloc/UpdateProfileBloc.dart';
import 'package:tmobiledev/bloc/UserMeBloc.dart';
import 'package:tmobiledev/model/StatusModel.dart';
import 'package:tmobiledev/model/user/UserModel.dart';
import 'package:tmobiledev/model/user/UserStatusModel.dart';
import 'package:tmobiledev/page/MainAppPage.dart';
import 'package:tmobiledev/page/profile/ProfilePage.dart';
import 'package:tmobiledev/utils/DateTimeUtils.dart';
import 'package:tmobiledev/utils/DialogUtils.dart';
import 'package:tmobiledev/utils/pref_manager.dart';

class ProfileEditPage extends StatefulWidget {
  UserModel userModel;
  ProfileEditPage({Key key, this.userModel}) : super(key: key);

  @override
  ProfileEditPageState createState() => ProfileEditPageState();
}

class ProfileEditPageState extends State<ProfileEditPage> {
  double shortTestside, shortWidthsize;
  final _firstNameController = TextEditingController();
  final _lasttNameController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _textBirthdateController = TextEditingController();
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool loading = false;
  String birthDate = "";
  String showBirthDate = "";

  List<String> listValue = [
    "ชื่อจริง", "นามสกุล", "วันเดือนปีเกิด", "เบอร์โทรศัพท์"
  ];

  @override
  void initState() {
    Prefs.load();
    String name = widget.userModel.checkin_user_name;
    birthDate = widget.userModel.checkin_user_birth_date;
    _firstNameController.text = name.split("  ")[0];
    _lasttNameController.text = name.split("  ")[1];
    _telephoneController.text = widget.userModel.checkin_user_telephone;
    _textBirthdateController.text = DateTimeUtils().getDateString(birthDate);
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
            ModalProgressHUD(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(
                  top: shortWidthsize / 5,
                  bottom: shortTestside / 10,
                  left: shortTestside / 10,
                  right: shortTestside / 10,
                ),
                child: SingleChildScrollView(
                  child: Container(
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
                        Container(
                          margin: EdgeInsets.only(top: shortWidthsize / 10),
                          child: Text('แก้ไขโปรไฟล์', style: TextStyle(color: Colors.white,
                              fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                          ),
                        ),
                        _boxInputFirstname(),
                        _boxInputLastname(),
                        _boxTelephone(),
                        _boxBirthdate(),
                        _buttonRegister(),
                      ],
                    ),
                  ),
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
        child: Stack(
          children: <Widget>[
            Row(
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
                  child: _layoutRegister(),
                ),
              ],
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
      ),
    );
  }

  Widget _layoutRegister(){
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
                Text('แก้ไขโปรไฟล์', style: TextStyle(color: Colors.white,
                    fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                ),
                _boxInputFirstname(),
                _boxInputLastname(),
                _boxTelephone(),
                _boxBirthdate(),
                _buttonRegister(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconShowPassword(){
    if(showPassword){
      return Icon(Icons.visibility_off_sharp, color: Colors.lightBlue);
    } else {
      return Icon(Icons.remove_red_eye_sharp, color: Colors.lightBlue);
    }
  }

  Widget _boxInputFirstname(){
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
                    child: Icon(Icons.person_rounded, color: Colors.lightBlue),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: shortTestside / 100),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: "Firstname",
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

  Widget _boxInputLastname(){
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
                    child: Icon(Icons.person_rounded, color: Colors.lightBlue),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: shortTestside / 100),
                      child: TextField(
                        controller: _lasttNameController,
                        decoration: InputDecoration(
                          hintText: "Lastname",
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

  Widget _boxTelephone(){
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
                    child: Icon(Icons.phone_android, color: Colors.lightBlue),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: shortTestside / 100),
                      child: TextField(
                        controller: _telephoneController,
                        decoration: InputDecoration(
                          hintText: "Telephone number",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
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

  Widget _boxBirthdate(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: shortTestside / 100),
      child: Card(
        shadowColor: Colors.lightBlue,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(shortTestside / 10)),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(shortTestside / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(shortTestside / 100),
                    child: Icon(Icons.calendar_today, color: Colors.lightBlue),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: shortTestside / 100),
                      child: TextField(
                        controller: _textBirthdateController,
                        decoration: InputDecoration(
                          hintText: "ฺBirth date",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        readOnly: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkResponse(
              child: Container(
                padding: EdgeInsets.all(shortTestside / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(shortTestside / 100),
                      child: Icon(Icons.calendar_today, color: Colors.transparent),
                    ),
                    Expanded(
                      child: Container(

                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => _selectDate(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonRegister(){
    return Container(
      margin: EdgeInsets.all(shortTestside / 100),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {
          // _setLoading(true),
          _registerValidate(),
        },
        child: Text('SAVE', style: TextStyle(color: Colors.white)),
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)
        ),
      ),
    );
  }

  _selectDate() async {
    final DateTime pickedDate = await showRoundedDatePicker(
        context: context,
        locale: Locale("th", "TH"),
        era: EraMode.BUDDHIST_YEAR,
        borderRadius: shortTestside / 60,
        height: shortTestside / 1.5,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.pinkAccent,
          textTheme: TextTheme(
            body1: TextStyle(color: Color.fromRGBO(88, 133, 217, 1)),
            caption: TextStyle(color: Color.fromRGBO(88, 133, 217, 1),),
          ),
        ),
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2060)
    );
    if (pickedDate != null){
      _textBirthdateController.text = _formatDateTimetoString(pickedDate);
      setState(() {
        showBirthDate = _formatDateTimetoString(pickedDate);
        birthDate = _formatDateTime(pickedDate);
      });
    }
  }

  _registerValidate(){
    List<String> inputValue = [];
    List<String> checkValue = [];
    inputValue.add(_firstNameController.text.toString());
    inputValue.add(_lasttNameController.text.toString());
    inputValue.add(birthDate);
    inputValue.add(_telephoneController.text.toString());
    for(int i = 0;i < listValue.length;i++){
      if(inputValue[i] == ""){
        checkValue.add(listValue[i]);
      }
    }

    String message = "คุณยังไม่ได้กรอกข้อมูล\n";
    for(int i = 0;i < checkValue.length;i++){
      message += '\n - ${checkValue[i]}';
    }
    message += "\n\nกรุณากรอกข้อมูลให้ครบทุกช่อง";

    if(checkValue.length > 0){
      _showDialog(message);
    } else {
      _updateProfile(widget.userModel.checkin_user_email, '${inputValue[0]}  ${inputValue[1]}',
          inputValue[2], inputValue[3], "");
    }
  }

  _showDialog(String message){
    DialogUtils().showDialogMessage(context, "คำเตือน", message);
  }

  functionClose(BuildContext context) {
    Navigator.pop(context);
  }

  _updateProfile(String email, String name, String birth_date, String telephone,
      String address){
    _setLoading(true);
    String authen = Prefs.getString(Prefs.PREF_AUTHEN);
    Future<StatusModel> updateProfile = updateProfileBloc.updateProfile(authen,
        email, name, birth_date, telephone, address);
    updateProfile.then((value) => {
      if(value.error == ""){
        if(value.status){
          _getUserMe(authen, value.messge),
        } else {
          _showDialog(value.messge),
        }
      } else {
        _showDialog(value.error)
      },
      _setLoading(false),
    });
  }

  _getUserMe(String authen, String message){
    _setLoading(true);
    Future<UserStatusModel> userme = userMeBloc.getUserMe(authen);
    userme.then((value) => {
      if(value.error == ""){
        print("data ${value.data}"),
        if(value.status){
          sendBroadcast(ProfilePage.KEY_UPDATE_PROFILE),
          sendBroadcast(MainAppPage.KEY_MAIN_UPDATE_PROFILE),
          _saveUserme(jsonEncode(value.data.toJson())),
          functionClose(context),
          _showDialog(value.messge),
        } else {
          functionClose(context),
          _showDialog(value.messge),
        }
      } else {
        print('userme error : ${value.error}'),
        functionClose(context),
        _showDialog(value.messge),
      },
      _setLoading(false),
    });
  }

  _setLoading(bool _loading){
    setState(() {
      loading = _loading;
    });
  }

  _saveUserme(String usermeJson){
    Prefs.setString(Prefs.PREF_USER_ME, usermeJson);
  }

  String _formatDateTime(DateTime dateTime) {
    var formetter = DateFormat('yyyy-MM-dd');
    return formetter.format(dateTime);
  }

  String _formatDateTimetoString(DateTime dateTime) {
    var formetter = DateFormat('dd MMMM yyyy', "th");
    List<String> strDate = formetter.format(dateTime).split(" ");
    if(strDate[0][0] == '0'){
      strDate[0] = strDate[0][1];
    }
    int year = int.parse(strDate[2]) + 543;
    return "${strDate[0]} ${strDate[1]} ${year.toString()}";
  }
}