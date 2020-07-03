// import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show DateFormat;
import 'package:shareLearnTeach/src/utils/constants.dart';
import 'package:shareLearnTeach/src/models/user.dart';

class Topic {
  Topic({
    this.id,
    this.authorId,
    this.username,
    this.avatar,
    this.title,
    this.description,
    this.count,
    this.dateTime,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    var dateForComparison = DateTime.parse(json['modified'] as String);

    return Topic(
        id: json['id'] as String,
        authorId: json['author_id'] as String,
        username: json['username'] as String,
        avatar: json['avatar'] as String,
        title: json['title'] as String,
        description: removeAllHtmlTags(json['description'] as String),
        count: json['count'],
        // category: '',
        // dateTime: moment.from(dateForComparison),
        dateTime: checkDate(dateForComparison));
  }

  // String id = UniqueKey().toString();
  String id;
  String authorId;
  String username;
  String avatar;
  String title;
  String description;
  String count;
  // double rate;
  String dateTime;

  static Future<List<Topic>> getTopics(
      String keyword, int startCount, int incrementCount) async {
    // final String token = await User.getToken();

    startCount = startCount ~/ incrementCount;

    print(
        'url: ${Constants.WORDPRESS_URL + 'mobile/v2/topics?s=$startCount&i=$incrementCount&k=$keyword'}');

    final http.Response response = await http.get(
      Constants.WORDPRESS_URL +
          'mobile/v2/topics?s=$startCount&i=$incrementCount&k=$keyword',
      //   headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      // }
    );

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      if (response.body != '') {
        final Iterable list = json.decode(response.body) as Iterable;
        // print('list: ${list.length}');
        return list.map((dynamic model) => Topic.fromJson(model)).toList();
      }
      return <Topic>[];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to save resources');
    }
  }

  static String checkDate(DateTime dateToCheck) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return DateFormat.Hm().format(dateToCheck);
    }
    if (aDate == yesterday) {
      return 'Yesterday';
    }
    return DateFormat.yMMMd().format(dateToCheck);
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
