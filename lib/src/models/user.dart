import 'dart:async';
import 'dart:convert';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shareLearnTeach/src/screens/signin.dart';
import 'package:shareLearnTeach/src/screens/web_view.dart';
import 'package:shareLearnTeach/src/utils/constants.dart';

enum UserState { available, away, busy }

class User {
  String id;
  String displayName;
  String email;
  String gender;
  String membershipLevel;
  DateTime dateOfBirth;
  String avatar;
  String address;
  List<dynamic> favourites;
  String token;
  UserState userState;

  User(
      {this.id,
      this.displayName,
      this.email,
      this.avatar,
      this.favourites,
      this.token,
      this.membershipLevel});

  factory User.fromLoginJson(Map<String, dynamic> json) {
    // print('user json: $json');
    return User(
      id: json['user']['id'],
      displayName: json['user']['display_name'],
      email: json['user']['email'],
      avatar: json['user']['avatar'],
      token: json['token']['jwt_token'],
      favourites: json['user']['favourites'].toList(),
      membershipLevel: json['user']['membership_level'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      avatar: json['avatar'],
      favourites: json['favourites'],
      token: json['token'],
      membershipLevel: json['membership_level'],
    );
  }

  User.init();

  User.basic(this.displayName, this.avatar, this.userState);

  User.advanced(this.displayName, this.email, this.gender, this.dateOfBirth,
      this.avatar, this.address, this.userState);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'avatar': avatar,
      'favourites': favourites,
      'token': token,
      'membership_level': membershipLevel
    };
  }

  Future<http.Response> loginUser(String username, String password) async {
    final http.Response response = await http.post(_apiEndpoint,
        headers: _headers,
        body: json.encode({'username': username, 'password': password}));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final User user = User.fromLoginJson(json.decode(response.body));

      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString('user', json.encode(user.toMap()));

      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return response;
    }
  }

  Future<dynamic> getPaymentIntent(int amount) async {
    final http.Response response = await http
        .get(Constants.WORDPRESS_URL + 'mobile/v2/stripe?amount=$amount');
    return json.decode(response.body);
  }

  Future<http.Response> register(
      String name,
      String surname,
      String email,
      String password,
      String membershipId,
      double amount,
      String paymentIntentId) async {
    const String _apiEndpoint = Constants.WORDPRESS_URL + 'mobile/v2/register';
    final http.Response response = await http.post(_apiEndpoint,
        headers: _headers,
        body: json.encode({
          'name': name,
          'surname': surname,
          'email': email,
          'password': password,
          'membershipId': membershipId,
          'amount': amount,
          'paymentIntentId': paymentIntentId
        }));
    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');
    if (response.statusCode == 200) {
      print('loginUser fired');
      return await loginUser(email, password);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return response;
    }
  }

  static void saveFavourites(dynamic favourites) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    dynamic user = json.decode(preferences.getString('user'));
    user = User.fromJson(user);
    user.favourites = favourites;
    preferences.setString('user', json.encode(user.toMap()));
  }

  Future<User> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final dynamic user = json.decode(preferences.getString('user'));

    return User.fromJson(user);
  }

  static Future<String> getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final dynamic user = json.decode(preferences.getString('user'));
    final User userToken = User.fromJson(user);

    if (userToken.token != null) {
      return userToken.token;
    }

    return '';
  }

  Future<bool> isLoggedIn(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final userString = preferences.getString('user');
      if (userString == null) {
        throw "error";
      }
    } on Exception catch (exception) {
      Navigator.of(context).push(_createRoute());
      return false;
    } catch (error) {
      Navigator.of(context).push(_createRoute());
      return false;
    }
    return true;
  }

  Future<bool> isPremiumUser(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final dynamic user = json.decode(preferences.getString('user'));
    final User userToken = User.fromJson(user);

    if (userToken.membershipLevel == null) {
      _upgradeNow(context);
      return false;
    }

    return true;
  }

  Future<bool> logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');

    return true;
  }

  static const String _apiEndpoint = Constants.WORDPRESS_URL + 'api/v1/token';
  static final Object _headers = {'Content-Type': 'application/json'};

  User getCurrentUser() {
    return User.advanced(
        'Andrew R. Whitesides',
        'andrew@gmail.com',
        'Male',
        DateTime(1993, 12, 31),
        'img/user2.jpg',
        '4600 Isaacs Creek Road Golden, IL 62339',
        UserState.available);
  }

  String getDateOfBirth() {
    return DateFormat('yyyy-MM-dd').format(dateOfBirth);
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignInWidget(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Future<void> _upgradeNow(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Premium Membership Required'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text(
                  'Premium resources requires premium membership. Please consider upgrading to become a premium member to download them.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('Upgrade Now'),
            onPressed: () {
              Navigator.of(context).pop();
              _openMembershipPage(context);
            },
          ),
        ],
      );
    },
  );
}

void _openMembershipPage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute<void>(builder: (BuildContext context) {
    return const WebViewWebPage(
        title: 'Premium Membership Options',
        url:
            'https://sharelearnteach.com/membership-account/membership-levels/');
  }));
}
