import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/resource.dart';

// ignore: must_be_immutable
class ResourceItemWidget extends StatelessWidget {
  ResourceItemWidget({Key key, this.resource, this.checkAccountPermissions})
      : super(key: key);

  Resource resource;

  Function checkAccountPermissions;
  var unescape = new HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          checkAccountPermissions(resource, context);
        },
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 10,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Container(
                //   height: 60,
                //   width: 60,
                //   decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.all(Radius.circular(100)),
                //     image: DecorationImage(image: AssetImage(resource.user.avatar), fit: BoxFit.cover),
                //   ),
                // ),
                // const SizedBox(width: 15),
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
                                  unescape.convert(resource.title),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .merge(TextStyle(
                                          color: Theme.of(context).hintColor)),
                                ),
                                Text(
                                  unescape.convert(resource.description),
                                  style: Theme.of(context).textTheme.body1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 3,
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                          // Chip(
                          //   padding: const EdgeInsets.all(0),
                          //   label: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: <Widget>[
                          //       Text(resource.rate.toString(),
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
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
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
                  resource.dateTime,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
                const SizedBox(width: 10),
                Icon(
                  UiIcons.file_1,
                  color: Theme.of(context).focusColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  resource.category,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
                const SizedBox(width: 10),
                Icon(
                  UiIcons.user_1,
                  color: Theme.of(context).focusColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    resource.username,
                    style: Theme.of(context).textTheme.caption,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
