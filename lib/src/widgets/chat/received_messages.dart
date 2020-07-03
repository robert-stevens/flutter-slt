import 'package:flutter/material.dart';
import 'package:shareLearnTeach/src/models/reply.dart';

import 'my_circle_avatar.dart';

class ReceivedMessagesWidget extends StatelessWidget {
  final dynamic message;
  const ReceivedMessagesWidget({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MyCircleAvatar(
            margin: EdgeInsets.only(top: 20, right: 10),
            imgUrl: message.avatar,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        message.username,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        message.dateTime,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .8),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Color(0xfff9f9f9),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  // child: Stack(
                  //   children: <Widget>[
                  //     Text(
                  //       message.description,
                  //       style: Theme.of(context).textTheme.body1.apply(
                  //             color: Colors.black87,
                  //       ),
                  //     ),
                  //     Positioned(
                  //       child: Align(
                  //         alignment: FractionalOffset.bottomRight,
                  //         child: Text(
                  //           message.dateTime,
                  //           style: Theme.of(context).textTheme.caption,
                  //           textAlign: TextAlign.end,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  child: Text(
                    message.description,
                    style: Theme.of(context).textTheme.body1.apply(
                          color: Colors.black87,
                        ),
                  ),
                ),
              ],
            ),
          )
          // SizedBox(width: 5),
          // Container(
          //   margin: EdgeInsets.only(top: 20),
          //   child: Text(
          //       message.dateTime,
          //       style: Theme.of(context).textTheme.caption,
          //       overflow: TextOverflow.ellipsis,
          //   )

          // )
        ],
      ),
    );
  }
}
