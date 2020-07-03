import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show DateFormat;

import 'package:shareLearnTeach/src/utils/constants.dart';
import 'package:shareLearnTeach/src/models/activity.dart';
import 'package:shareLearnTeach/src/models/user.dart';

class Comment {
  String authorId;
  String username;
  String avatar;
  String description;
  String dateTime;

  Comment({
    this.authorId,
    this.username,
    this.avatar,
    this.description,
    this.dateTime,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    print('json: $json');
    return Comment(
      authorId: json['user_id'] as String,
      username: json['username'],
      avatar: json['avatar'] as String,
      description: removeAllHtmlTags(json['content'] as String),
      // category: '',
      dateTime: DateFormat.yMMMd()
          .format(DateTime.parse(json['date_recorded'] as String)),
    );
  }

  static Future<List<Comment>> getComments(
      int activityId, int startCount, int incrementCount) async {
    final String token = await User.getToken();

    startCount = startCount ~/ incrementCount;

    // print('url: ${Constants.WORDPRESS_URL+'mobile/v2/replies?s=$startCount&i=$incrementCount&id=$activityId'}');

    final http.Response response = await http.get(
        Constants.WORDPRESS_URL + 'mobile/v2/comments?id=$activityId',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      if (response.body != '') {
        final Iterable list = json.decode(response.body) as Iterable;
        // print('list: ${list.length}');
        return list.map((dynamic model) => Comment.fromJson(model)).toList();
      }
      return <Comment>[];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to save resources');
    }
  }

  static Future<int> postComment(Comment comment, Activity activity) async {
    final String token = await User.getToken();

    // print(toJson(comment, activityId));

    final http.Response response = await http.post(
        Constants.WORDPRESS_URL + 'mobile/v2/comments',
        body: toJson(comment, activity),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    return response.statusCode;

    // var fakeResponse = "{\"id\":\"17139\",\"author_id\":\"8465\",\"username\":\"Robert Stevens\",\"avatar\":\"https:\\/\\/sharelearnteach.com\\/wp-content\\/uploads\\/2018\\/05\\/doc-large.png\",\"description\":\"Commenting on my own activity.\",\"modified\":\"2020-04-09 09:18:26\"}";
    // var data = json.decode(fakeResponse);
    // return Comment.fromJson(data);
  }

  static String toJson(Comment comment, Activity activity) {
    var mapData = Map();
    mapData["user_id"] = comment.authorId;
    mapData["content"] = comment.description;
    mapData["activity_id"] = activity.id;
    String data = json.encode(mapData);
    return data;
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
