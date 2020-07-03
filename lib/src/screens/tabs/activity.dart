import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shareLearnTeach/src/models/activity.dart';
import 'package:shareLearnTeach/src/models/resource.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/widgets/ActivityItemWidget.dart';
import 'package:shareLearnTeach/src/widgets/EmptyResourcesWidget.dart';

class ActivityWidget extends StatefulWidget {
  const ActivityWidget({Key key, this.user});

  final User user;

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget>
    with SingleTickerProviderStateMixin {
  Timer debounceTimer;
  List<Activity> _activityList = <Activity>[];
  List<dynamic> _favourites = <dynamic>[];
  bool _isLoading = true;
  User _user = new User();
  int _page = 1;

  Animation animationOpacity;
  AnimationController animationController;

  Future<void> _getDefaultList() async {
    this.setState(() {
      _isLoading = true;
    });

    final List<Activity> newItems = await Activity.getActivityList(_page);

    _activityList.addAll(newItems);

    setState(() {
      _activityList = _activityList;
      _isLoading = false;
      _page = _page + 1;
    });
  }

  Future<void> _getUser() async {
    User user = new User();
    if (widget.user == null) {
      user = await _user.getUser();
    } else {
      user = widget.user;
    }
    if (_user != null) {
      setState(() {
        _user = user;
        _favourites = _user.favourites;
      });
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();

    _getDefaultList();
    _getUser();

    super.initState();
  }

  ListView _buildItemsForListView(BuildContext context, int index) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (BuildContext context, int index) {
        return ActivityItemWidget(
            activity: _activityList.elementAt(index),
            isLikedReal:
                _favourites.contains(_activityList.elementAt(index).id),
            likeActivity: _likeActivity,
            checkForAttachments: _checkForAttachments,
            user: _user);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 30,
        );
      },
      itemCount: _activityList.length,
      primary: false,
      shrinkWrap: true,
    );
  }

  Future<void> _checkForAttachments(int docId, BuildContext context) async {
    // attachments requires user to be logged in
    var isLoggedIn = await _user.isLoggedIn(context);
    if (!isLoggedIn) {
      return;
    }
    // requires user to have a premium account.
    var isPremiumUser = await _user.isPremiumUser(context);
    if (!isPremiumUser) {
      return;
    }
    this.setState(() {
      _isLoading = true;
    });

    var data = await Resource.getResources(null, '', 10, 10, docId: docId);
    var resource = data.elementAt(0);

    this.setState(() {
      _isLoading = false;
    });
    if (resource.attachments.length == 1) {
      openAttachment(resource.attachments[0].guid as String);
    } else {
      _settingModalBottomSheet(context, resource.attachments);
    }
  }

  Future<bool> _likeActivity(bool isLiked, int id) async {
    if (_favourites.contains(id)) {
      _favourites.removeWhere((item) => item == id);
    } else {
      _favourites.add(id);
    }
    this.setState(() {
      _favourites = _favourites;
    });
    Activity.markActivityAsFavourite(id);
    await Future.delayed(const Duration(milliseconds: 200), () {});
    return !isLiked;
  }

  // Future<void> _markActivityAsFavourite(int id) async {
  //   var favourites = await Activity.markActivityAsFavourite(id);

  //   // print('new favs: $favourites');

  //   this.setState(() {
  //     _favourites = favourites;
  //   });
  // }

  Future<void> openAttachment(String guid) async {
    setState(() {
      _isLoading = true;
    });

    if (await canLaunch(guid)) {
      setState(() {
        _isLoading = false;
      });
      await launch(guid);
    } else {
      setState(() {
        _isLoading = false;
      });
      throw 'Could not launch $guid';
    }
  }

  void _settingModalBottomSheet(BuildContext context, dynamic attachments) {
    showModalBottomSheet<dynamic>(
        context: context,
        builder: (BuildContext bc) {
          return Column(
            children: <Widget>[
              ListTile(
                title: const Text('Attachments:'),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: Icon(Icons.attach_file),
                        title: Text(attachments[index].title as String),
                        onTap: () =>
                            openAttachment(attachments[index].guid as String));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemCount: attachments.length as int,
                ),
              ),
              Container(height: 50),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 20),
              !_isLoading && _activityList.isEmpty
                  ? EmptyResourcesWidget()
                  : SizedBox(height: 1),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!_isLoading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        setState(() {
                          _isLoading = true;
                        });
                        // start loading data
                        _getDefaultList();
                      }
                    },
                    child: _isLoading && _activityList.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _buildItemsForListView(
                            context, _activityList.length)),
              ),
              Container(
                height: _isLoading && _activityList.length > 0 ? 50.0 : 0,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // Container(height: 15.0,),
              // Image(image: NetworkImage('https://sharelearnteach.com/wp-content/uploads/2020/04/BounceTogether-ShareLearnTeach-Alternative.png')),
            ]));
  }
}
