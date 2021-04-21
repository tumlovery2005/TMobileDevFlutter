import 'dart:convert';

import 'package:abhi_flutter_alertdialog/abhi_flutter_alertdialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmobiledev/model/user/UserModel.dart';
import 'package:tmobiledev/page/LoginPage.dart';
import 'package:tmobiledev/page/ProfilePage.dart';
import 'package:tmobiledev/utils/DateTimeUtils.dart';
import 'package:tmobiledev/utils/EnterExitRoute.dart';
import 'package:tmobiledev/utils/ImageProfileFailUtils.dart';
import 'package:tmobiledev/utils/pref_manager.dart';

import 'TestColorsPage.dart';
import 'TokenPage.dart';

class MainAppPage extends StatefulWidget {

  @override
  MainAppPageState createState() => MainAppPageState();
}

class MainAppPageState extends State<MainAppPage> {
  double shortTestside;
  int bottomSelectedIndex = 0;
  UserModel userMe = null;

  @override
  void initState() {
    Prefs.load();
    _getUserMe();
    super.initState();
  }

  final List<Widget> _pageList = [
    TestColorsPage(title: "Page 1"),
    TestColorsPage(title: "Page 2"),
    TestColorsPage(title: "Page 3"),
  ];

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    shortTestside = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text('', style: TextStyle(color: Colors.white,
            fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      drawer: Drawer(
        child: Container(
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: getDrawerHeader(),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
              ),
              InkResponse(
                child: getItemMenuList('โปรไฟล์'),
                onTap: () => {
                  Navigator.push(context, EnterExitRoute(enterPage: ProfilePage())),
                },
              ),
              InkResponse(
                child: getItemMenuList("Generate token"),
                onTap: () => {
                  Navigator.push(context, EnterExitRoute(enterPage: TokenPage())),
                },
              ),
              InkResponse(
                child: getItemMenuList('ออกจากระบบ'),
                onTap: () => {
                  _dialogLogOut()
                },
              ),
            ],
          ),
        )
      ),
      body: IndexedStack(
        index: bottomSelectedIndex,
        children: [..._pageList],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.white,
        currentIndex: bottomSelectedIndex,
        items: buildBottomNavBarItems(),
        onTap: (index) {
          pageChanged(index);
        },
      ),
    );
  }

  Widget getDrawerHeader(){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getIconProfile(userMe.checkin_user_photo),
              _textName(userMe.checkin_user_name),
            ],
          ),
          getWidgetText('เบอร์โทรศัพท์ : ', userMe.checkin_user_telephone, Colors.white),
          getWidgetText('อีเมล : ', userMe.checkin_user_email, Colors.white),
        ],
      ),
    );
  }

  Widget getIconProfile(String photo) {
    return Container(
      width: shortTestside / 6,
      height: shortTestside / 6,
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(100),
        child: Container(
          color: Colors.grey,
          child: photo != "" ? CachedNetworkImage(
            imageUrl: photo,
            placeholder: (context, url) => ImageProfileFailUtils().imageFail(shortTestside / 6),
            errorWidget: (context, url, error) => ImageProfileFailUtils().imageFail(shortTestside / 6),
            fit: BoxFit.cover,
          ) : ImageProfileFailUtils().imageFail(shortTestside / 6),
        ),
      ),
    );
  }

  Widget getItemMenuList(String itemMenu){
    return Container(
      padding: EdgeInsets.only(
        top: shortTestside / 25,
        left: shortTestside / 25,
        right: shortTestside / 25,
      ),
      child: Text(itemMenu, style: TextStyle(color: Colors.black,
          fontSize: shortTestside / 20, fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget getWidgetTextName(){
    if(userMe.checkin_user_name != null){
      return _textName(userMe.checkin_user_name);
    } else {
      return _textName("Firstname Lastname");
    }
  }

  Widget getWidgetText(String title, String value, Color color){
    return Container(
      child: Row(
        children: <Widget>[
          _text(title, color),
          Expanded(child: _text(value, color)),
        ],
      ),
    );
  }

  Widget _textName(String name){
    return Container(
      margin: EdgeInsets.all(shortTestside / 50),
      child: Text(name, style: TextStyle(fontSize: shortTestside / 20,
          color: Colors.white)
      ),
    );
  }

  Widget _text(String value, Color color){
    return Container(
      margin: EdgeInsets.only(
        top: shortTestside / 25,
      ),
      child: Text(value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: color)
      ),
    );
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[..._pageList],
    );
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: new Icon(Icons.person_rounded),
          label: "Token"
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.work_sharp),
          label: "Work"
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
        label: "Info"
      )
    ];
  }

  _getUserMe(){
    String json = Prefs.getString(Prefs.PREF_USER_ME);
    UserModel userModel = UserModel.fromJson(jsonDecode(json));
    setState(() {
      userMe = userModel;
    });
  }

  _dialogLogOut(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog1(
        context: context,
        title: 'คำเตือน',
        content: 'คุณต้องการออกจากระบบหรือไม่',
        action1: 'ใช่',
        action2: 'ไม่',
        function1: () => _LogOut(),
        function2: () => functionB(context),
        div: true,
        txtAlign: 2,
        radius: shortTestside / 80,
        boxColor: Colors.lightBlue,
        btnTxtColor: Colors.white,
        txtColor: Colors.white,
      ),
    );
  }

  functionB(BuildContext context) {
    Navigator.pop(context);
  }

  _LogOut(){
    Prefs.clear();
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      // pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }
}