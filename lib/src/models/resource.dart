// import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shareLearnTeach/src/utils/constants.dart';
import 'package:shareLearnTeach/src/models/category.dart';
import 'package:shareLearnTeach/src/models/user.dart';

class Attachment {
  Attachment({this.title, this.guid});

  factory Attachment.fromJson(Map<String, dynamic> json) {
    // print('attachment: $json');
    return Attachment(title: json['title'], guid: json['guid']);
  }

  String title;
  String guid;
}

class Resource {
  Resource(
      {this.username,
      this.title,
      this.description,
      this.category,
      this.dateTime,
      this.attachments});

  factory Resource.fromJson(
      Map<String, dynamic> json, List<Category> categoryList) {
    // print(categoryList);
    // print(json['category'][0]);
    return Resource(
        username: json['username'],
        title: json['title'],
        description: removeAllHtmlTags(json['content']),
        category: json['category'].length > 0
            ? Resource.getCategoryName(json['category'][0], categoryList)
            : '',
        // category: '',
        dateTime: DateFormat.yMMMd().format(DateTime.parse(json['modified'])),
        attachments: json['attachments']
            .map((dynamic attachment) => Attachment.fromJson(attachment))
            .toList()
        // username: 'demo',
        // category: Category.getCategoryName(json['categories'][0]),
        // category: json['categories'][0]
        );
  }

  // String id = UniqueKey().toString();
  String username;
  String title;
  String description;
  String category;
  // double rate;
  String dateTime;
  List<dynamic> attachments;

  static Future<List<Resource>> getResources(List<Category> categoryList,
      String keyword, int startCount, int incrementCount,
      {int docId}) async {
    // final String token = await User.getToken();
    String categoryParams;

    if (categoryList != null) {
      categoryParams = await Category.returnCategoryParams(categoryList);
    }

    startCount = startCount ~/ incrementCount;

    // print('url: ${Constants.WORDPRESS_URL+'mobile/v2/resources?s=$startCount&i=$incrementCount&c=$categoryParams&k=$keyword&id=$docId'}');

    final http.Response response = await http.get(
      Constants.WORDPRESS_URL +
          'mobile/v2/resources?s=$startCount&i=$incrementCount&c=$categoryParams&k=$keyword&id=$docId',
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      // }
    );

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      if (response.body != '') {
        final Iterable list = json.decode(response.body);
        final List<Category> categoryList = await Category.getCategoryList();
        // print('list: ${list.length}');
        return list
            .map((dynamic model) => Resource.fromJson(model, categoryList))
            .toList();
      }
      return <Resource>[];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to save resources');
    }
  }

  static String getCategoryName(int id, List<Category> categoryList) {
    final int index = categoryList.indexWhere((Category item) => item.id == id);
    Category category = new Category();
    if (index != -1) {
      category = categoryList.elementAt(index);
    } else {
      category.name = "Uncategorized";
    }
    return category.name;
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
