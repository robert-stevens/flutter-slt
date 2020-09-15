import 'dart:convert';
import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter/material.dart';
import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/activity.dart';
import 'package:shareLearnTeach/src/models/comment.dart';
import 'package:shareLearnTeach/src/models/user.dart';
// import 'package:shareLearnTeach/src/screens/forums/global.dart';
import 'package:shareLearnTeach/src/widgets/ActivityItemWidget.dart';
import 'package:shareLearnTeach/src/widgets/chat/widgets.dart';

class CommentsScreen extends StatefulWidget {
  // Declare a field that holds the Todo.
  final Activity activity;
  bool isLikedReal;

  // In the constructor, require a Todo.
  CommentsScreen({Key key, @required this.activity, this.isLikedReal})
      : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  User _user;
  List<Comment> _comments = <Comment>[];
  bool _isSendingMessage = false;
  bool _isLoading = true;
  int _incrementCount = 10;

  _CommentsScreenState() {
    User().getUser().then((User val) => setState(() {
          _user = val;
        }));
  }

  @override
  void initState() {
    super.initState();
    _getComments();
  }

  Future<void> _getComments() async {
    var startCount = _comments.length + _incrementCount;

    final List<Comment> newItems = await Comment.getComments(
        widget.activity.id, startCount, _incrementCount);

    if (_comments == null || _comments.isEmpty) {
      _comments = newItems;
    } else {
      _comments.addAll(newItems);
    }

    setState(() => {_comments = _comments, _isLoading = false});
  }

  Future<void> _sendComment(BuildContext context) async {
    // print('text length: ${_controller.text.length}');
    if (_controller.text.length < 3) {
      // Then show a snackbar.
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Please enter something first.")));
    } else {
      setState(() {
        _isSendingMessage = true;
      });

      var currentComments = _comments;

      Comment newComment = Comment(
          authorId: _user.id,
          description: _controller.text,
          avatar: _user.avatar,
          dateTime: DateFormat.yMMMd().format(DateTime.now()));

      currentComments.add(newComment);
      _controller.clear();

      setState(() {
        _comments = currentComments;
        _isSendingMessage = false;
      });

      var response = await Comment.postComment(newComment, widget.activity);

      if (response == 200) {
        // print('great success: $response');
      } else {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Whoops. Something went wrong.")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('activity id: ${widget.activity.id}');
    // print('topic id: ${widget.topic.id}');
    // print('author id: ${widget.topic.authorId}');
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(_comments.length),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Activity',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ActivityItemWidget(
                          commentsCount: _comments.length,
                          activity: widget.activity,
                          isLikedReal: widget.isLikedReal)),
                  _isLoading
                      ? Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: CircularProgressIndicator()))
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(15),
                          shrinkWrap: true,
                          itemCount: _comments.length,
                          itemBuilder: (ctx, i) {
                            if (_comments[i].authorId == _user.id) {
                              return SentMessageWidget(
                                  message: _comments.elementAt(i));
                            } else {
                              return ReceivedMessagesWidget(
                                  message: _comments.elementAt(i));
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.grey)
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 15),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 133.0,
                            ),
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                reverse: true,
                                // child: TextField(
                                //   maxLines: null,
                                // ),
                                child: TextField(
                                  controller: _controller,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  // expands: true,
                                  decoration: InputDecoration(
                                      // contentPadding: EdgeInsets.only(top: 20),
                                      hintText: "Type Something...",
                                      hintStyle:
                                          Theme.of(context).textTheme.subhead,
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(13.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle),
                  child: SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: _isSendingMessage
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : InkWell(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onTap: () {
                                _sendComment(context);
                              },
                            )),
                )
              ],
            ),
          )
        ]));
  }
}
