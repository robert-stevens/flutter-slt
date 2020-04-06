import 'package:flutter/material.dart';
import 'package:shareLearnTeach/src/screens/on_boarding.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 8,
      navigateAfterSeconds: new OnBoardingWidget(),
      title: new Text(
        ' Business Listing \n Directory ',
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).accentColor.withOpacity(0.7),
      loaderColor: Colors.white,
      
    );
  }
}