import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shareLearnTeach/src/models/category.dart';
import 'package:shareLearnTeach/src/models/topic.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/screens/forums/topic.dart';
import 'package:shareLearnTeach/src/screens/web_view.dart';
import 'package:shareLearnTeach/src/widgets/CardTopicItem.dart';
// import 'package:shareLearnTeach/src/widgets/DrawerWidget.dart';
import 'package:shareLearnTeach/src/widgets/EmptyResourcesWidget.dart';
// import 'package:shareLearnTeach/src/widgets/FilterWidget.dart';
import 'package:shareLearnTeach/src/widgets/SearchBarWidget.dart';

class ForumsScreen extends StatefulWidget {
  final User user;
  final List<Category> categoryList;

  const ForumsScreen({Key key, this.categoryList, this.user});

  @override
  _ForumsScreenState createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  User _user = new User();
  String _keyword = '';
  int incrementCount = 10;
  Timer debounceTimer;
  List<Topic> _topics = <Topic>[];
  String layout = 'list';
  bool _isLoading = true;

  _ForumsScreenState() {
    User().getUser().then((User val) => setState(() {
          _user = val;
        }));

    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted &&
            _searchQuery.text.length >= 3 &&
            _searchQuery.text != _keyword) {
          _getDefaultList(_searchQuery.text);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getDefaultList(_keyword);
    _getUser();
  }

  Future<void> _getUser() async {
    User user = new User();
    if (widget.user == null) {
      user = await _user.getUser();
    } else {
      user = widget.user;
    }
    if (_user != null) {
      setState(() => _user = user);
    }
  }

  Future<void> _getDefaultList(String keyword) async {
    this.setState(() {
      _isLoading = true;
    });
    var startCount = _topics.length + incrementCount;
    final List<Topic> newItems =
        await Topic.getTopics(keyword, startCount, incrementCount);
    // if keywords don't match, we assume it's a new search
    if (_keyword != keyword) {
      _topics = newItems;
    } else {
      _topics.addAll(newItems);
    }

    setState(() {
      _topics = _topics;
      _isLoading = false;
      _keyword = keyword;
    });
  }

  ListView _buildItemsForListView(BuildContext context, int index) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            child: CardTopicItem(topic: _topics.elementAt(index)),
            onTap: () async {
              if (await _user.isLoggedIn(context)) {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return TopicScreen(topic: _topics.elementAt(index));
                }));

                return;
              }
            });
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 30,
        );
      },
      itemCount: _topics.length,
      primary: false,
      shrinkWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(
              controller: _searchQuery,
              hideCategoryFilter: true,
            ),
          ),
          const SizedBox(height: 20),
          !_isLoading && _topics.isEmpty
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
                    _getDefaultList(_keyword);
                  }
                },
                child: _isLoading && _topics.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _buildItemsForListView(context, _topics.length)),
          ),
          Container(
            height: _isLoading && _topics.length > 0 ? 50.0 : 0,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
