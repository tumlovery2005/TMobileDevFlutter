import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:tmobiledev/model/user/UserModel.dart';
import 'package:tmobiledev/page/LocationStampPage.dart';
import 'package:tmobiledev/page/LoginPage.dart';
import 'package:tmobiledev/page/ProfilePage.dart';
import 'package:tmobiledev/utils/CustomView.dart';
import 'package:tmobiledev/utils/DateTimeUtils.dart';
import 'package:tmobiledev/utils/DialogUtils.dart';
import 'package:tmobiledev/utils/EnterExitRoute.dart';
import 'package:tmobiledev/utils/ImageProfileFailUtils.dart';
import 'package:tmobiledev/utils/pref_manager.dart';

import '../utils/DialogUtils.dart';
import 'ChatPage.dart';
import 'LocationStampPage.dart';
import 'LoginPage.dart';
import 'TestColorsPage.dart';
import 'TokenPage.dart';

class MainAppPage extends StatefulWidget {

  @override
  MainAppPageState createState() => MainAppPageState();
}

class MainAppPageState extends State<MainAppPage> {
  double shortTestside;
  double shortWidthsize;
  int bottomSelectedIndex = 0;
  UserModel userMe = null;

  @override
  void initState() {
    Prefs.load();
    _getUserMe();
    super.initState();
  }

  final List<Widget> _pageList = [
    LocationStampPage(),
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
    shortWidthsize = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait){
      return _isPortrait();
    } else {
      return _isLandscape();
    }
  }

  Widget _isPortrait(){
    if(shortTestside < 600){
      return _isPortraitPhone();
    } else {
      return _isPortraitTablet();
    }
  }

  Widget _isPortraitPhone(){
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text('', style: TextStyle(color: Colors.white,
            fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      drawer: _DrawerLayout(shortTestside / 6),
      body: IndexedStack(
        index: bottomSelectedIndex,
        children: [..._pageList],
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _isPortraitTablet(){
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Row(
            children: <Widget>[
              _DrawerLayout(shortTestside / 8),
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 3.0,
                    title: Text('', style: TextStyle(color: Colors.white,
                        fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.lightBlue,
                  ),
                  body: IndexedStack(
                    index: bottomSelectedIndex,
                    children: [..._pageList],
                  ),
                  bottomNavigationBar: _buildNavigationBar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _isLandscape(){
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              width: (shortWidthsize / 10) * 3,
              child: _DrawerLayout(shortTestside / 6),
            ),
            Expanded(
              child: Scaffold(
                body: IndexedStack(
                  index: bottomSelectedIndex,
                  children: [..._pageList],
                ),
                bottomNavigationBar: _buildNavigationBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _DrawerLayout(double width){
    return Drawer(
        child: Container(
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(shortWidthsize / 50),
                child: getDrawerHeader(width),
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
              CustomView().buttonCustomTextIcon(Icons.person, "โปรไฟล์",
                  shortWidthsize / 30, _nextProfilePage),
              CustomView().buttonCustomTextIcon(Icons.logout, "ออกจากระบบ",
                  shortWidthsize / 30, _dialogLogOut),
            ],
          ),
        )
    );
  }

  Widget getDrawerHeader(double width){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getIconProfile(userMe.checkin_user_photo, width),
          getWidgetText('', userMe.checkin_user_name, Colors.white),
          getWidgetText('อีเมล : ', userMe.checkin_user_email, Colors.white),
        ],
      ),
    );
  }

  Widget _buildNavigationBar(){
    return BottomNavigationBar(
      backgroundColor: Colors.green,
      selectedItemColor: Colors.lightBlue,
      unselectedItemColor: Colors.white,
      currentIndex: bottomSelectedIndex,
      items: buildBottomNavBarItems(),
      onTap: (index) {
        pageChanged(index);
      },
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

  Widget getWidgetText(String title, String value, Color color){
    return Container(
      margin: EdgeInsets.only(top: shortTestside / 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _text(title, color),
          Expanded(child: _text(value, color)),
        ],
      ),
    );
  }

  Widget _text(String value, Color color){
    return Container(
      alignment: Alignment.topLeft,
      child: Text(value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
        ),
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
    DialogUtils().showDialogYesNo(context, 'คำเตือน', 'คุณต้องการออกจากระบบหรือไม่', _LogOut);
  }

  _nextProfilePage(){
    Navigator.push(context, EnterExitRoute(enterPage: ProfilePage()));
  }

  _LogOut(BuildContext _context){
    Prefs.clear();
    Navigator.pop(context);
    Navigator.push(context, EnterExitRoute(enterPage: LoginPage()));
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