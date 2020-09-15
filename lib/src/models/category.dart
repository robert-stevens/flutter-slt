import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:shareLearnTeach/config/ui_icons.dart';
// import 'package:shareLearnTeach/src/services/wordpress.dart';
import 'package:shareLearnTeach/src/utils/constants.dart';
import 'package:shareLearnTeach/src/models/user.dart';
// import 'package:shareLearnTeach/src/models/utilities.dart';

class Category {
  Category(
      {this.id, this.name, this.count, this.icon, this.selected, this.color});

  factory Category.fromJson(Map<String, dynamic> json) {
    // print('Category json: $json');
    return Category(
      id: json['id'],
      name: json['name'],
      count: json['count'],
      icon: UiIcons.sport,
      selected: false,
      color: Colors.greenAccent,
    );
  }

  int id;
  String name;
  int count;
  bool selected;
  IconData icon;
  Color color;

  static Future<String> returnCategoryParams(
      List<Category> categoryList) async {
    String categoryParams = '';
    for (Category category in categoryList) {
      if (category.selected) {
        categoryParams = '$categoryParams' '${category.id},';
      }
    }
    return categoryParams;
  }

  static Future<void> getAndSaveCategories() async {
    // final String token = await User.getToken();

    final http.Response response = await http.get(
      Constants.WORDPRESS_URL + 'wp/v2/categories',
      //   headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      // }
    );

    // print(response.statusCode);
    // print(response.body);
    // inspect(response.body);

    if (response.statusCode == 200) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString('categories', response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to save catogories');
    }
  }

  static Future<List<Category>> getCategoryList() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final categories = preferences.getString('categories');
    final Iterable list = json.decode(categories);
    return list.map((dynamic model) => Category.fromJson(model)).toList();
  }
}
