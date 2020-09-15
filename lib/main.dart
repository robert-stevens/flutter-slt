import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shareLearnTeach/config/app_config.dart' as config;
import 'package:shareLearnTeach/route_generator.dart';

import 'package:shareLearnTeach/src/models/category.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((SharedPreferences prefs) {
    runApp(MyApp(
      prefs: prefs,
    ));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({this.prefs});

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _getAndSaveCategories();

    return MaterialApp(
      title: 'Share Learn Teach',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        accentColor: config.Colors().mainColor(1),
        focusColor: config.Colors().textSecondeColor(1),
        hintColor: config.Colors().textAccentColor(1),
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
          headline: TextStyle(
              fontSize: 20.0, color: config.Colors().textSecondeColor(1)),
          display1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().textSecondeColor(1)),
          display2: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().textSecondeColor(1)),
          display3: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.white),
          display4: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().textSecondeColor(1)),
          subhead: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().textSecondeColor(1)),
          title: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().textMainColor(1)),
          body1: TextStyle(
              fontSize: 12.0, color: config.Colors().textSecondeColor(1)),
          body2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().textSecondeColor(1)),
          caption: TextStyle(
              fontSize: 12.0, color: config.Colors().textAccentColor(0.6)),
        ),
      ),
    );
  }

  _getAndSaveCategories() async {
    await Category.getAndSaveCategories();
  }
}
