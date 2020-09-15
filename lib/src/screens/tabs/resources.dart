import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:shareLearnTeach/src/widgets/DrawerWidget.dart';
import 'package:shareLearnTeach/src/models/resource.dart';
// import 'package:shareLearnTeach/src/models/route_argument.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/models/category.dart';
import 'package:shareLearnTeach/src/screens/web_view.dart';
// import 'package:shareLearnTeach/src/widgets/FilterWidget.dart';
import 'package:shareLearnTeach/src/widgets/ResourceItemWidget.dart';
import 'package:shareLearnTeach/src/widgets/SearchBarWidget.dart';
import 'package:shareLearnTeach/src/widgets/EmptyResourcesWidget.dart';

class ResourcesWidget extends StatefulWidget {
  const ResourcesWidget({Key key, this.categoryList, this.user});

  final List<Category> categoryList;
  final User user;

  @override
  _ResourcesWidgetState createState() => _ResourcesWidgetState();
}

class _ResourcesWidgetState extends State<ResourcesWidget> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  Timer debounceTimer;
  List<Resource> _resourcesList = <Resource>[];
  User _user = new User();
  String layout = 'list';
  String _keyword = '';
  bool _isLoading = true;
  int incrementCount = 10;

  _ResourcesWidgetState() {
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

  Future<void> _getDefaultList(String keyword) async {
    this.setState(() {
      _isLoading = true;
    });

    final List<Resource> newItems = await Resource.getResources(
        widget.categoryList, keyword, _resourcesList.length, incrementCount);

    if (_keyword != keyword) {
      _resourcesList = newItems;
    } else {
      _resourcesList.addAll(newItems);
    }

    setState(() => {
          _resourcesList = _resourcesList,
          _isLoading = false,
          _keyword = keyword,
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
      setState(() => _user = user);
    }
  }

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

  Future<void> _checkForAttachments(
      Resource resource, BuildContext context) async {
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
    if (resource.attachments.length == 1) {
      openAttachment(resource.attachments[0].guid as String);
    } else {
      _settingModalBottomSheet(context, resource.attachments);
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

  ListView _buildItemsForListView(BuildContext context, int index) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (BuildContext context, int index) {
        return ResourceItemWidget(
            resource: _resourcesList.elementAt(index),
            checkAccountPermissions: _checkForAttachments);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 30,
        );
      },
      itemCount: _resourcesList.length,
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
                controller: _searchQuery, onClear: _getDefaultList),
          ),
          const SizedBox(height: 20),
          !_isLoading && _resourcesList.isEmpty
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
                    _getDefaultList(_keyword);
                    // start loading data
                  }
                },
                child: _isLoading && _resourcesList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _buildItemsForListView(context, _resourcesList.length)),
          ),
          Container(
            height: _isLoading && _resourcesList.length > 0 ? 50.0 : 0,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          // Flexible(child:
          //   _isLoading ?
          //     const Center(child: CircularProgressIndicator())
          //   :
          //   _buildItemsForListView(context, _resourcesList.length)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
