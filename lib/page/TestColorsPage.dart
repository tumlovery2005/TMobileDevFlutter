import 'package:flutter/material.dart';

class TestColorsPage extends StatefulWidget {
  TestColorsPage({Key key, this.title}) : super(key: key);

  String title;

  @override
  TestColorsPageSate createState() => TestColorsPageSate();
}

class TestColorsPageSate extends State<TestColorsPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // color: widget.color,
        child: Center(
          child: Text('${widget.title}'),
        ),
      ),
    );
  }

}