import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class TokenPage extends StatefulWidget {

  @override
  TokenPageState createState() => TokenPageState();
}

class TokenPageState extends State<TokenPage> {
  double shortTestside;
  int bottomSelectedIndex = 0;

  int num1 = 0, num2 = 0, num3 = 0, num4 = 0, num5 = 0, num6 = 0;
  int endTime = 0;
  CountdownTimerController controller;
  Timer _timer;

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
        title: Text('Token', style: TextStyle(color: Colors.white,
            fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    layoutNumberToken(),
                    CountdownTimer(
                      controller: controller,
                      endTime: endTime,
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        if (time == null) {
                          return getTextToken();
                        } else {
                          if(controller.isRunning){
                            _timer =  Timer(Duration(seconds: 1), () => { _randomNumber() });
                          } else {
                            return getTextToken();
                          }
                        }
                        return Text('Time : ${time.min} min ${time.sec} sec',
                          style: TextStyle(fontSize: shortTestside / 10),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(

              ),
            ],
          )
        ),
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

  Widget getTextToken(){
    return Text('Token : ${num1}${num2}${num3}${num4}${num5}${num6}',
        style: TextStyle(fontSize: shortTestside / 10),
    );
  }

  Widget layoutNumberToken(){
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _BoxTextNumber(num1),
          _BoxTextNumber(num2),
          _BoxTextNumber(num3),
          _BoxTextNumber(num4),
          _BoxTextNumber(num5),
          _BoxTextNumber(num6),
        ],
      ),
    );
  }

  Widget _BoxTextNumber(int number){
    return Expanded(
        child: Container(
          color: Colors.deepOrangeAccent,
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          height: 40,
          child: Text(number.toString(), style:TextStyle(color: Colors.white, fontSize: 25,
              fontWeight: FontWeight.bold)
          ),
        )
    );
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: new Icon(Icons.loop_sharp),
          label: "Refresh token"
      ),
      BottomNavigationBarItem(
          icon: new Icon(Icons.stop_circle),
          label: "Stop"
      ),
    ];
  }

  void bottomTapped(int index) {
    if(index == 0){
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 180;
      controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    } else if(index == 1) {
      if(controller != null){
        controller.disposeTimer();
      }
      _timer.cancel();
    }
    setState(() {
      bottomSelectedIndex = index;
      // pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  _randomNumber(){
    var rng = new Random();
    setState(() {
      num1 = rng.nextInt(9);
      num2 = rng.nextInt(9);
      num3 = rng.nextInt(9);
      num4 = rng.nextInt(9);
      num5 = rng.nextInt(9);
      num6 = rng.nextInt(9);
    });
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  void dispose() {
    if(controller != null){
      controller.dispose();
    }
    if(_timer != null){
      _timer.cancel();
    }
    super.dispose();
  }
}