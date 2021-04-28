import 'package:flutter/material.dart';

class LocationStampPage extends StatefulWidget {

  @override
  LocationStampPageState createState() => LocationStampPageState();
}

class LocationStampPageState extends State<LocationStampPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }

}