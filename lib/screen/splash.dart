import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tintin_app/screen/gridview.dart';
import 'package:tintin_app/screen/titles.dart';

class SplashPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen(
      seconds: 2,
      title:new Text(
          'Please Wait',
        style:TextStyle(
          fontSize: 40,
          color: Colors.white
        ),
      ),
      imageBackground: new AssetImage('assets/bg.jpg'),
      photoSize: 80.00,

      loaderColor: Colors.white,
      navigateAfterSeconds: Titles(),
    );
  }
}
