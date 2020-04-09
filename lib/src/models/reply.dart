import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show DateFormat;

import 'package:shareLearnTeach/src/utils/constants.dart';
import 'package:shareLearnTeach/src/models/topic.dart';
import 'package:shareLearnTeach/src/models/user.dart';

class Reply {

  String authorId;
  String username;
  String avatar;
  String description;
  String dateTime;

  Reply({this.authorId, this.username, this.avatar, this.description, this.dateTime,});

  factory Reply.fromJson(Map<String,dynamic> json) {
    // print('json: $json');
    return Reply(
      authorId: json['author_id'] as String, 
      username: json['username'],
      avatar: json['avatar'] as String, 
      description: removeAllHtmlTags(json['description'] as String), 
      // category: '',
      dateTime: DateFormat.yMMMd().format(DateTime.parse(json['modified'] as String)),
    );
  }

  static Future<List<Reply>> getReplies(String parentId, int startCount, int incrementCount) async {

    final String token = await User.getToken();

    startCount = startCount ~/ incrementCount;
    
    // print('url: ${Constants.WORDPRESS_URL+'mobile/v2/replies?s=$startCount&i=$incrementCount&id=$parentId'}');

    final http.Response response = 
      await http.get(Constants.WORDPRESS_URL+'mobile/v2/replies?s=$startCount&i=$incrementCount&id=$parentId', 
        headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      if(response.body != ''){
        final Iterable list = json.decode(response.body) as Iterable; 
        print('list: ${list.length}');
        return list.map((dynamic model) => Reply.fromJson(model)).toList();
      }
      return <Reply>[];

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to save resources');
    }
  }

  static Future<Reply> postReply(Reply reply, Topic topic) async {

    final String token = await User.getToken();

    // print(toJson(reply, topicId));

    final http.Response response = 
      await http.post(Constants.WORDPRESS_URL+'mobile/v2/replies', 
        body: toJson(reply, topic),
        headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('data: $data');
      return Reply.fromJson(data);
    } else {   
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to post reply.');

    }

    // var fakeResponse = "{\"id\":\"17139\",\"author_id\":\"8465\",\"username\":\"Robert Stevens\",\"avatar\":\"https:\\/\\/sharelearnteach.com\\/wp-content\\/uploads\\/2018\\/05\\/doc-large.png\",\"description\":\"Replying on my own topic.\",\"modified\":\"2020-04-09 09:18:26\"}";
    // var data = json.decode(fakeResponse);
    // return Reply.fromJson(data);

  }

  static String toJson(Reply reply, Topic topic) {
    var mapData = Map();
    mapData["post_author"] = reply.authorId;
    mapData["post_content"] = reply.description;
    mapData["post_parent"] = topic.id;
    mapData["post_title"] = 'Reply To: ${topic.title}';
    mapData["post_type"] = 'reply';
    mapData["post_status"] = 'publish';
    String data = json.encode(mapData);
    return data;
  }

  static Reply getJobBulletinTopic(){
    return Reply(
      username: 'SLT Support - Steven Phyffer',
      avatar: 'https://sharelearnteach.com/wp-content/uploads/avatars/2292/5e5b72e01b12f-bpfull.jpg', 
      description: 'Have you got a vacancy that needs filling? Post your position here which is publicly accessible and hosts 10000 PE teachers from across the UK! Why advertise anywhere else!', 
      dateTime: 'Jan 20, 2020',
    );
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }

}