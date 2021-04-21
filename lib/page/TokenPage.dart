import 'package:flutter/material.dart';

class TokenPage extends StatefulWidget {

  @override
  TokenPageState createState() => TokenPageState();
}

class TokenPageState extends State<TokenPage> {
  int bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(

                ),
              ),
              Container(

              ),
            ],
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepOrange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: bottomSelectedIndex,
        items: buildBottomNavBarItems(),
        onTap: (index) {
          bottomTapped(index);
        },
      ),
    );
  }

  Widget layoutNumberToken(){
    return Row(

    );
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: new Icon(Icons.copy),
          label: "Copy"
      ),
      BottomNavigationBarItem(
          icon: new Icon(Icons.loop_sharp),
          label: "New token"
      ),
    ];
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      // pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

}