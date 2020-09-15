import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:like_button/like_button.dart';

import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/activity.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/widgets/RichTextWidget.dart';
import 'package:shareLearnTeach/src/screens/ActivityComments.dart';

// ignore: must_be_immutable
class ActivityItemWidget extends StatelessWidget {
  ActivityItemWidget(
      {Key key,
      this.activity,
      this.user,
      this.likeActivity,
      this.commentsCount, //set via ActivityComments
      this.isLikedReal,
      this.checkForAttachments})
      : super(key: key);

  Activity activity;
  User user;
  bool isLikedReal;
  int commentsCount;
  Function checkForAttachments;
  Function likeActivity;
  var unescape = new HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.10),
              offset: Offset(0, 4),
              blurRadius: 10)
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 4.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(activity.userAvatar),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            activity.displayName,
                            style: Theme.of(context).textTheme.title.merge(
                                TextStyle(color: Theme.of(context).hintColor)),
                          ),
                          Expanded(
                            child: Text(
                              ' ${activity.username}',
                              style: Theme.of(context).textTheme.caption,
                              softWrap: false,
                            ),
                          ),
                          Text('${activity.dateTime}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  // color: AppGrey,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1),
                          // Icon(
                          //   Icons.keyboard_arrow_down,
                          //   // color: AppGrey,
                          // )
                        ],
                      ),
                      activity.description != ''
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, bottom: 8.0),
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: RichTextView(
                                      text: unescape
                                          .convert(activity.description))),
                            )
                          : Container(),
                      activity.title != ''
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, bottom: 8.0),
                              child: activity.description != ''
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.6)),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      // padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                              alignment: Alignment.topLeft,
                                              child: RichTextView(
                                                text: unescape
                                                    .convert(activity.title),
                                              ))))
                                  : Container(
                                      alignment: Alignment.topLeft,
                                      child: RichTextView(
                                        text: unescape.convert(activity.title),
                                      )))
                          : Container(),
                      activity.type == 'activity_link'
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, bottom: 8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.6)),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            children: <Widget>[
                                              RichTextView(
                                                text: unescape.convert(
                                                    activity.link.title),
                                              ),
                                              RichTextView(
                                                text: unescape.convert(
                                                    activity.link.description),
                                              ),
                                              RichTextView(
                                                text: activity.link.link,
                                              )
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          )))))
                          : Container(),
                      activity.type == 'bp_doc_created'
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: 2.0, bottom: 8.0),
                              child: InkWell(
                                child: ClipRRect(
                                  child: Image.asset('img/resource.png'),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                onTap: () => checkForAttachments(
                                    activity.secondaryItemId, context),
                              ))
                          : Container(),
                      activity.type == 'activity_photo'
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: 2.0, bottom: 8.0),
                              child: InkWell(
                                child: ClipRRect(
                                  child: Image(
                                      image: NetworkImage(activity.photo)),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                onTap: () => checkForAttachments(
                                    activity.secondaryItemId, context),
                              ))
                          : Container()
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: 64.0,
                ),
                InkWell(
                    onTap: () async {
                      var isLoggedIn = await user.isLoggedIn(context);
                      if (isLoggedIn) {
                        activity.commentsCount = await Navigator.push(
                          context,
                          // Create the SelectionScreen in the next step.
                          MaterialPageRoute(
                              builder: (context) => CommentsScreen(
                                  activity: activity,
                                  isLikedReal: isLikedReal)),
                        );
                      }
                      // print("commentsCount: ${activity.commentsCount}");
                    },
                    // onTap: () => Navigator.of(context).push(
                    //         MaterialPageRoute<void>(
                    //             builder: (BuildContext context) {
                    //       return CommentsScreen(
                    //           activity: activity, isLikedReal: isLikedReal);
                    //     })),
                    child: Row(children: <Widget>[
                      Icon(
                        UiIcons.chat,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                          commentsCount != null
                              ? '$commentsCount'
                              : '${activity.commentsCount}',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400)),
                    ])),
                SizedBox(
                  width: 20.0,
                ),
                LikeButton(
                  onTap: (bool isLiked) async {
                    // print(activity.id);
                    var isLoggedIn = await user.isLoggedIn(context);
                    if (isLoggedIn) {
                      if (isLikedReal) {
                        activity.likesCount = activity.likesCount - 1;
                      } else {
                        activity.likesCount = activity.likesCount + 1;
                      }
                      return likeActivity(isLikedReal, activity.id);
                    }
                  },
                  circleColor: CircleColor(
                      start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      isLikedReal ? Icons.favorite : Icons.favorite_border,
                      color: Theme.of(context).accentColor,
                    );
                  },
                  countBuilder: (int count, bool isLiked, String text) {
                    var color =
                        isLikedReal ? Colors.deepPurpleAccent : Colors.grey;
                    Widget result;
                    if (activity.likesCount == 0) {
                      result = Text(
                        "love",
                        style: TextStyle(color: color),
                      );
                    } else
                      result = Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    return result;
                  },
                ),
                // IconButton(
                //   icon: Icon(
                //     isLikedReal ? Icons.favorite : Icons.favorite_border,
                //     color: Theme.of(context).accentColor,
                //   ),
                //   onPressed: () {
                //     likeActivity(activity.id);
                //   },
                // ),
                SizedBox(
                  width: 10.0,
                ),
                Text('${activity.likesCount}',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  width: 20.0,
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    final RenderBox box = context.findRenderObject();
                    Share.share(
                        activity.title != ''
                            ? activity.title
                            : activity.description,
                        subject: activity.linkToShare,
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
