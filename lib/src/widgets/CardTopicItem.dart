import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/topic.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardTopicItem extends StatelessWidget {
  CardTopicItem({Key key, this.topic}) : super(key: key);

  Topic topic;

  @override
  Widget build(BuildContext context) {
    // print('topic: ${topic.title}');
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 10,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
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
                              topic.title,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .merge(TextStyle(color: Theme.of(context).hintColor)),
                            ),
                            Text(
                              topic.description,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.body1,
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Icon(
                            //       UiIcons.user_1,
                            //       color: Theme.of(context).focusColor,
                            //       size: 20,
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Text(
                            //       topic.username,
                            //       style: Theme.of(context).textTheme.caption,
                            //       overflow: TextOverflow.fade,
                            //       softWrap: false,
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Icon(
                            //       UiIcons.calendar,
                            //       color: Theme.of(context).focusColor,
                            //       size: 20,
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Text(
                            //       topic.dateTime,
                            //       style: Theme.of(context).textTheme.caption,
                            //       overflow: TextOverflow.fade,
                            //       softWrap: false,
                            //     ),
                            //   ],
                            // ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(children: <Widget>[
                        Text(
                          topic.dateTime,
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                        Chip(
                          // padding: const EdgeInsets.all(6),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(topic.count,
                                  style: Theme.of(context)
                                      .textTheme
                                      .body2
                                      .merge(TextStyle(color: Theme.of(context).primaryColor))),
                            ],
                          ),
                          backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                          shape: const StadiumBorder(),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
