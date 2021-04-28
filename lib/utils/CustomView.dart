import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomView {

  Widget buttonCustomTextIcon(IconData icon, String strButton, double margin,
      Function function){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: margin, right: margin),
      alignment: Alignment.topLeft,
      child: ElevatedButton(
        onPressed: () => {
          function(),
        },
        child: Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(icon),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: margin),
                  child: Text(strButton, style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        clipBehavior: Clip.antiAlias,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)
        ),
      ),
    );
  }
}