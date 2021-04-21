import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmobiledev/utils/ImageProfileFailUtils.dart';

class ProfilePage extends StatefulWidget {

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  double shortTestside;

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
        title: Text('โปรไฟล์', style: TextStyle(color: Colors.white,
            fontSize: shortTestside / 15, fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(shortTestside / 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getIconProfile(""),
            ],
          ),
        ),
      ),
    );
  }

  Widget getIconProfile(String photo) {
    return Container(
      width: shortTestside / 4,
      height: shortTestside / 4,
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(100),
        child: Container(
          color: Colors.grey,
          child: photo != "" ? CachedNetworkImage(
            imageUrl: photo,
            placeholder: (context, url) => ImageProfileFailUtils().imageFail(shortTestside / 4),
            errorWidget: (context, url, error) => ImageProfileFailUtils().imageFail(shortTestside / 4),
            fit: BoxFit.cover,
          ) : ImageProfileFailUtils().imageFail(shortTestside / 4),
        ),
      ),
    );
  }
}