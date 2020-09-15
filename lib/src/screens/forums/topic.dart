import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/reply.dart';
import 'package:shareLearnTeach/src/models/topic.dart';
import 'package:shareLearnTeach/src/models/user.dart';
// import 'package:shareLearnTeach/src/screens/forums/global.dart';
import 'package:shareLearnTeach/src/widgets/chat/widgets.dart';

class TopicScreen extends StatefulWidget {
  // Declare a field that holds the Todo.
  final Topic topic;

  // In the constructor, require a Todo.
  TopicScreen({Key key, @required this.topic}) : super(key: key);

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  User _user;
  List<Reply> _replies = <Reply>[]; 
  bool _isSendingMessage = false;
  bool _isLoading = true;
  int _incrementCount = 10;

  _TopicScreenState() {
    User().getUser().then((User val) => setState(() {
      _user = val;
    }));
  }

  @override
  void initState() {
    super.initState();
    _getReplies(); 
  }

  Future<void> _getReplies() async {


    var startCount = _replies.length + _incrementCount;

    final List<Reply> newItems = await Reply.getReplies(widget.topic.id, startCount, _incrementCount);

    if (_replies == null || _replies.isEmpty){
      _replies = newItems;
    } else {
      _replies.addAll( newItems);
    }

    setState(() => {
      _replies = _replies,
      _isLoading = false
    });
  }

  Future<void> _sendReply(BuildContext context) async {

    // print('text length: ${_controller.text.length}');
    if(_controller.text.length < 3){
        // Then show a snackbar.
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please enter something first.")));
    } else {
      setState((){
        _isSendingMessage = true;
      });

      Reply newReply = Reply(
        authorId: _user.id,
        description: _controller.text
      );

      var response = await Reply.postReply(newReply, widget.topic);

      if(response != null){
        // print('great success: $response');

        _replies.add(response);
        _controller.clear();

        setState((){
          _replies = _replies;
          _isSendingMessage = false;
        });
        
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Whoops. Something went wrong.")));
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    // print('topic id: ${widget.topic.id}');
    // print('author id: ${widget.topic.authorId}');
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(UiIcons.return_icon, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyCircleAvatar(
              imgUrl: widget.topic.avatar,
            ),
            SizedBox(width: 15),
            Expanded(
              child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${widget.topic.title} by ${widget.topic.username}',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.button,
                  overflow: TextOverflow.ellipsis,
                ),
                // Text(
                //   'by ${widget.topic.username}',
                //   style: Theme.of(context).textTheme.button,
                //   overflow: TextOverflow.clip,
                // ),
                // Text(
                //   "Online",
                //   style: Theme.of(context).textTheme.subtitle.apply(
                //         color: myGreen,
                //       ),
                // )
              ],
            )
            ),
            // Text(
            //       "Ofsted - Curriculum Implementation - Why/How/What",
            //       maxLines: 2,
            //       style: Theme.of(context).textTheme.subhead,
            //       softWrap: true,
            //       overflow: TextOverflow.visible,
            //       // overflow: TextOverflow.clip,
            //     ),
            
          ],
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.phone),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.videocam),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.more_vert),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(child: _isLoading ? const Center(
                child: CircularProgressIndicator()) : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: _replies.length,
                    itemBuilder: (ctx, i) {

                      if (_replies[i].authorId == _user.id) {
                        return SentMessageWidget(message:  _replies.elementAt(i));
                      } else {
                        return ReceivedMessagesWidget(message:  _replies.elementAt(i));
                      }
                    },
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
                                            hintStyle: Theme.of(context).textTheme.subhead,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: TextField(
                              //     controller: _controller,
                              //     keyboardType: TextInputType.multiline,
                              //     maxLines: 4,
                              //     // expands: true,
                              //     decoration: InputDecoration(
                              //       contentPadding: EdgeInsets.only(top: 20),
                              //         hintText: "Type Something...",
                              //         hintStyle: Theme.of(context).textTheme.subhead,
                              //         border: InputBorder.none),
                              //   ),
                              // ),
                              SizedBox(width: 15)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.all(13.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor, shape: BoxShape.circle),
                        child: 
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: 
                              _isSendingMessage ? 
                                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)
                              : 
                                InkWell(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    _sendReply(context);
                                  },
                                )
                          ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}