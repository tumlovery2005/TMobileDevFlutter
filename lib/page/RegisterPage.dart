import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tmobiledev/utils/DialogUtils.dart';

class RegisterPage extends StatefulWidget {

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  double shortTestside, shortWidthsize;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lasttNameController = TextEditingController();
  final _telephoneController = TextEditingController();
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool loading = false;

  List<String> listValue = [
    "อีเมล์", "รหัสผ่าน", "ยืนยันรหัสผ่าน", "ชื่อจริง", "นามสกุล", "เบอร์โทรศัพท์"
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
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_outlined),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 3.0,
          backgroundColor: Colors.lightBlue,
        ),
        body: ModalProgressHUD(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(
              top: shortTestside / 100,
              bottom: shortTestside / 100,
              left: shortTestside / 10,
              right: shortTestside / 10,
            ),
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
                  Container(
                    margin: EdgeInsets.only(top: shortWidthsize / 10),
                    child: Text('Register', style: TextStyle(color: Colors.white,
                        fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                    ),
                  ),
                  _boxInputEmail(),
                  _boxInputPassword(),
                  _boxInputConfirmPassword(),
                  _boxInputFirstname(),
                  _boxInputLastname(),
                  _boxTelephone(),
                  _buttonRegister(),
                ],
              ),
            ),
          ),
          inAsyncCall: loading,
        ),
      ),
    );
  }

  Widget _isLandscape(){
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 3.0,
        backgroundColor: Colors.lightBlue,
      ),
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
                Text('Register', style: TextStyle(color: Colors.white,
                    fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                ),
                _boxInputEmail(),
                _boxInputPassword(),
                _boxInputConfirmPassword(),
                _boxInputFirstname(),
                _boxInputLastname(),
                _boxTelephone(),
                _buttonRegister(),
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

  Widget _boxInputConfirmPassword(){
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
                            hintText: "Confirm password",
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

  Widget _buttonRegister(){
    return Container(
      margin: EdgeInsets.all(shortTestside / 100),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => {
          // _setLoading(true),
          _registerValidate(),
        },
        child: Text('Register', style: TextStyle(color: Colors.white)),
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
    inputValue.add(_emailController.text.toString());
    inputValue.add(_passwordController.text.toString());
    inputValue.add(_confirmPasswordController.text.toString());
    inputValue.add(_firstNameController.text.toString());
    inputValue.add(_lasttNameController.text.toString());
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
    }
  }

  _showDialog(String message){
    DialogUtils().showDialogMessage(context, "คำเตือน", message);
  }

  functionClose(BuildContext context) {
    Navigator.pop(context);
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