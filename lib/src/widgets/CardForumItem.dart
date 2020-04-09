import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/topic.dart';
import 'package:shareLearnTeach/src/widgets/ReadMoreText.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardForumItem extends StatelessWidget {
  CardForumItem({Key key, this.topic}) : super(key: key);

  Topic topic;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 10,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(image: NetworkImage(topic.avatar), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              topic.username,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .merge(TextStyle(color: Theme.of(context).hintColor)),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  UiIcons.calendar,
                                  color: Theme.of(context).focusColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  topic.dateTime,
                                  style: Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      // Chip(
                      //   padding: const EdgeInsets.all(0),
                      //   label: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //       Text('3',
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .body2
                      //               .merge(TextStyle(color: Theme.of(context).primaryColor))),
                      //       Icon(
                      //         Icons.star_border,
                      //         color: Theme.of(context).primaryColor,
                      //         size: 16,
                      //       ),
                      //     ],
                      //   ),
                      //   backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                      //   shape: const StadiumBorder(),
                      // ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        ReadMoreText(topic.description, trimLength: 100,)
        // Text(
        //   topic.description,
        //   style: Theme.of(context).textTheme.body1,
        //   overflow: TextOverflow.ellipsis,
        //   softWrap: false,
        //   maxLines: 3,
        // )
      ],
    );
  }
}
