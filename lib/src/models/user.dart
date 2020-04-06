import 'dart:async';
import 'dart:convert';

// import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shareLearnTeach/src/utils/constants.dart';

enum UserState { available, away, busy }

class User {

  User({this.id, this.displayName, this.email, this.avatar, this.token, this.membershipLevel});

  factory User.fromLoginJson(Map<String, dynamic> json) {
    print('user json: $json');
    return User(
      id: json['user']['id'],
      displayName: json['user']['display_name'],
      email: json['user']['email'],
      avatar: json['user']['avatar'],
      token: json['token']['jwt_token'],
      membershipLevel: json['user']['membership_level'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      avatar: json['avatar'],
      token: json['token'],
      membershipLevel: json['membership_level'],
    );
  }

  User.init();

  User.basic(this.displayName, this.avatar, this.userState);

  User.advanced(this.displayName, this.email, this.gender, this.dateOfBirth, this.avatar, this.address, this.userState);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'avatar': avatar,
      'token': token,
      'membership_level': membershipLevel
    };
  }

  Future<http.Response> loginUser(String username, String password) async {
    final http.Response response = await http.post(_apiEndpoint, headers: _headers, body: json.encode({'username': username, 'password': password}));

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final User user = User.fromLoginJson(json.decode(response.body));
      print(user);

      final SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('user', json.encode(user.toMap()));

      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // print('response: ${response.body}');
      return response;
      // throw Exception('Failed to login user');
    }
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

    // print('getToken');
    // print(user);
    print(User.fromJson(user));

    if(userToken.token != null){
      return userToken.token;
    }
    
    return '';
  }

  Future<bool> logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');

    return true;
  }

  static const String _apiEndpoint = Constants.WORDPRESS_URL+'api/v1/token';
  static final Object _headers = {'Content-Type': 'application/json'};

  int id;
  String displayName;
  String email;
  String gender;
  String membershipLevel;
  DateTime dateOfBirth;
  String avatar;
  String address;
  String token;
  UserState userState;

  User getCurrentUser() {
    return User.advanced('Andrew R. Whitesides', 'andrew@gmail.com', 'Male', DateTime(1993, 12, 31), 'img/user2.jpg',
        '4600 Isaacs Creek Road Golden, IL 62339', UserState.available);
  }

  String getDateOfBirth() {
    return DateFormat('yyyy-MM-dd').format(dateOfBirth);
  }
}
