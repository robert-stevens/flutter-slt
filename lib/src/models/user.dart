import 'dart:async';
import 'dart:convert';

// import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:listing/src/util/strings.dart';

enum UserState { available, away, busy }

class User {

  User({this.id, this.displayName, this.email, this.avatar, this.token});

  User.init();

  User.basic(this.displayName, this.avatar, this.userState);

  User.advanced(this.displayName, this.email, this.gender, this.dateOfBirth, this.avatar, this.address, this.userState);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'avatar': avatar,
    };
  }

  factory User.fromLoginJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      displayName: json['user']['display_name'],
      email: json['user']['email'],
      avatar: json['user']['avatar'],
      token: json['user']['token'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      avatar: json['avatar'],
      token: json['token'],
    );
  }

  Future<User> loginUser(String username, String password) async {
    final http.Response response = await http.post(_apiEndpoint, headers: _headers, body: json.encode({'username': username, 'password': password}));

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final User user = User.fromLoginJson(json.decode(response.body));
      // print(user);

      final SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('user', json.encode(user.toMap()));

      return user;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to login user');
    }
  }

  Future<User> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final dynamic user = json.decode(preferences.getString('user'));

    print(user);
    print('from json');
    print(User.fromJson(user));
    
    return User.fromJson(user);
  }

  Future<bool> logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');

    return true;
  }

  static const String _apiEndpoint = Strings.apiUrl+'api/v1/token';
  static final Object _headers = {'Content-Type': 'application/json'};

  int id;
  String displayName;
  String email;
  String gender;
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
