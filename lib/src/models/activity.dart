import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show DateFormat;
// import 'package:simple_moment/simple_moment.dart';
import 'package:shareLearnTeach/src/utils/constants.dart';
import 'package:shareLearnTeach/src/models/user.dart';

class LinkActivity {
  String title;
  String description;
  String link;

  LinkActivity({this.title, this.description, this.link});

  factory LinkActivity.fromJson(Map<String, dynamic> json) {
    return LinkActivity(
      title: json['title'],
      description: json['desc'],
      link: json['url'],
    );
  }
}

class Activity {
  Activity(
      {this.id,
      this.username,
      this.userAvatar,
      this.secondaryItemId,
      this.displayName,
      this.title,
      this.photo,
      this.link,
      this.linkToShare,
      this.type,
      this.description,
      this.category,
      this.dateTime,
      this.attachments,
      this.likesCount,
      this.commentsCount});

  factory Activity.fromJson(Map<String, dynamic> json) {
    // print(json['attachments'].map((dynamic attachment) => Attachment.fromJson(attachment)).toList());
    return Activity(
        id: json['id'],
        username: json['username'].contains('@')
            ? json['username']
            : '@${json['username']}',
        displayName: json['displayname'],
        title: removeAllHtmlTags(json['title']),
        link: json['type'] == 'activity_link'
            ? LinkActivity.fromJson(json['link_info'])
            : null,
        linkToShare: json['link'],
        type: json['type'],
        photo: json['photo'] != ''
            ? "https://sharelearnteach.com/wp-content/uploads/youzer/${json['photo']}"
            : '',
        secondaryItemId: json['secondary_item_id'],
        description: removeAllHtmlTags(json['content']['rendered']),
        userAvatar: json['user_avatar']['thumb'],
        dateTime: formatDate(json['date']),
        likesCount: json['social_info']['likes'],
        commentsCount: json['social_info']['comments']
        // dateTime: DateFormat.yMMMd().format(DateTime.parse(json['date'])),
        // dateTime: moment.from(dateForComparison),
        );
  }

  int id;
  String username;
  String displayName;
  String userAvatar;
  String title;
  String photo;
  String type;
  String linkToShare;
  LinkActivity link;
  String description;
  String category;
  // double rate;
  int likesCount;
  int commentsCount;
  int secondaryItemId;
  String dateTime;
  List<dynamic> attachments;

  static Future<List<Activity>> getActivityList(int page) async {
    // final String token = await User.getToken();

    // print('url: ${Constants.WORDPRESS_URL+'buddypress/v1/activity?page=$page'}');

    final http.Response response = await http.get(
      Constants.WORDPRESS_URL + 'buddypress/v1/activity?page=$page',
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
        // print('list: ${list.length}');
        return list.map((dynamic model) => Activity.fromJson(model)).toList();
      }
      return <Activity>[];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to save activities');
    }
  }

  static Future<dynamic> markActivityAsFavourite(int favouriteId) async {
    final String token = await User.getToken();
    final User user = await User().getUser();

    final http.Response response = await http.post(
        Constants.WORDPRESS_URL + 'mobile/v2/favourites',
        body: toJson(favouriteId, user.id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    // print(response.statusCode);
    // print(response.body);
    var favs = json.decode(response.body).toList();
    if (response.statusCode == 200) {
      User.saveFavourites(favs);
    }
    return favs;
  }

  static String toJson(int favouriteId, String userId) {
    var mapData = Map();
    mapData["user_id"] = userId;
    mapData["activity_id"] = favouriteId;
    String data = json.encode(mapData);
    return data;
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static String formatDate(String date) {
    // var moment = new Moment.now();
    var dateNow = DateTime.now();
    var dateForComparison = DateTime.parse(date);

    // print(dateNow.difference(dateForComparison).inHours);
    if (dateNow.difference(dateForComparison).inHours < 24) {
      return ' ${dateNow.difference(dateForComparison).inHours}h';
    } else {
      return ' ${DateFormat.MMMd().format(dateForComparison)}';
    }
  }
}
