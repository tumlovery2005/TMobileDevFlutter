import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tmobiledev/utils/DialogUtils.dart';

class ChangePasswordSettingPage extends StatefulWidget {

  @override
  ChangePasswordSettingPageState createState() => ChangePasswordSettingPageState();
}

class ChangePasswordSettingPageState extends State<ChangePasswordSettingPage> {
  double shortTestside, shortWidthsize;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool loading = false;
  String birthDate = "";
  String showBirthDate = "";

  List<String> listValue = [
    "อีเมล์", "รหัสผ่าน", "ยืนยันรหัสผ่าน", "ชื่อจริง", "นามสกุล", "วันเดือนปีเกิด", "เบอร์โทรศัพท์"
  ];

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
                          child: Text('เปลี่ยนรหัสผ่าน', style: TextStyle(color: Colors.white,
                              fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                          ),
                        ),
                        _boxInputOldPassword(),
                        _boxInputNewPassword(),
                        _boxInputConfirmNewPassword(),
                        _buttonChangePassword(),
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
                  child: _layoutChangePassword(),
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

  Widget _layoutChangePassword(){
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
                Text('เปลี่ยนรหัสผ่าน', style: TextStyle(color: Colors.white,
                    fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                ),
                _boxInputOldPassword(),
                _boxInputNewPassword(),
                _boxInputConfirmNewPassword(),
                _buttonChangePassword(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _boxInputOldPassword(){
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
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: "รหัสผ่านเดิม",
                            border: InputBorder.none,
                          ),
                          enableSuggestions: false,
                          obscureText: showConfirmPassword,
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
                      if(showConfirmPassword){
                        _setShowConfirmPassword(false),
                      } else {
                        _setShowConfirmPassword(true),
                      }
                    },
                  ),
                ],
              ),
            )
        )
    );
  }

  Widget _boxInputNewPassword(){
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
                            hintText: "รหัสผ่านใหม่",
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

  Widget _boxInputConfirmNewPassword(){
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
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: "ยืนยันรหัสผ่านใหม่",
                            border: InputBorder.none,
                          ),
                          enableSuggestions: false,
                          obscureText: showConfirmPassword,
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
                      if(showConfirmPassword){
                        _setShowConfirmPassword(false),
                      } else {
                        _setShowConfirmPassword(true),
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

  Widget _buttonChangePassword(){
    return Container(
      margin: EdgeInsets.all(shortTestside / 100),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {
          // _setLoading(true),
          _registerValidate(),
        },
        child: Text('บันทึก', style: TextStyle(color: Colors.white)),
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)
        ),
      ),
    );
  }

  _registerValidate(){
    List<String> inputValue = [];
    List<String> checkValue = [];
    inputValue.add(_passwordController.text.toString());
    inputValue.add(_confirmPasswordController.text.toString());
    inputValue.add(birthDate);
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
      if(inputValue[1] != inputValue[2]){
        _showDialog("Password และ Confirm password ไม่ตรงกัน");
      } else {
        _register(inputValue[0], inputValue[1], '${inputValue[3]}  ${inputValue[4]}',
            inputValue[5], inputValue[6], "");
      }
    }
  }

  _showDialog(String message){
    DialogUtils().showDialogMessage(context, "คำเตือน", message);
  }

  functionClose(BuildContext context) {
    Navigator.pop(context);
  }

  _register(String email, String password, String name, String birth_date,
      String telephone, String address){
    // _setLoading(true);
    // Future<StatusModel> register = registerBloc.register(email, password, name,
    //     birth_date, telephone, address);
    // register.then((value) => {
    //   if(value.error == ""){
    //     if(value.status){
    //       functionClose(context),
    //       _showDialog(value.messge),
    //     } else {
    //       _showDialog(value.messge),
    //     }
    //   } else {
    //     _showDialog(value.error)
    //   },
    //   _setLoading(false),
    // });
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

  _setShowConfirmPassword(bool _isShow){
    setState(() {
      showConfirmPassword = _isShow;
    });
  }

}