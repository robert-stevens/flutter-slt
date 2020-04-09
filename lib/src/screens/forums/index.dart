import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shareLearnTeach/src/screens/forums/topic.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:shareLearnTeach/src/widgets/DrawerWidget.dart';
import 'package:shareLearnTeach/src/models/topic.dart';
// import 'package:shareLearnTeach/src/models/route_argument.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/models/category.dart';
// import 'package:shareLearnTeach/src/screens/web_view.dart';
import 'package:shareLearnTeach/src/widgets/FilterWidget.dart';
import 'package:shareLearnTeach/src/widgets/CardTopicItem.dart';
import 'package:shareLearnTeach/src/widgets/SearchBarWidget.dart';
import 'package:shareLearnTeach/src/widgets/EmptyResourcesWidget.dart';

class ForumsScreen extends StatefulWidget {

  const ForumsScreen({Key key, this.categoryList});

  final List<Category> categoryList;

  @override
  _ForumsScreenState createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  User _user;
  String _profilePicture;
  String _keyword = '';
  int incrementCount = 10;
  Timer debounceTimer;
  List<Topic> _topics = <Topic>[]; 
  String layout = 'list';
  bool _isLoading = true;


  _ForumsScreenState() {
    User().getUser().then((User val) => setState(() {
      _user = val;
      _profilePicture = val.avatar;
    }));

    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted && _searchQuery.text.length >= 3 && _searchQuery.text != _keyword){
          _getDefaultList(_searchQuery.text);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getDefaultList(_keyword); 
  }

  Future<void> _getDefaultList(String keyword) async {
    this.setState((){
      _isLoading = true;
    });
    var startCount = _topics.length + incrementCount;
    final List<Topic> newItems = await Topic.getTopics(keyword, startCount, incrementCount);
    // print('existing array length: ${_topics.length}');
    // print('new array length: ${newItems.length}');
    // print('existing keyword $_keyword');
    // print('new keyword $keyword');
    // if keywords don't match, we assume it's a new search
    if (_keyword != keyword){
      _topics = newItems;
    } else {
      _topics.addAll( newItems);
    }

    setState(() => {
      _topics = _topics,
      _isLoading = false,
      _keyword = keyword
    });
  }

  // String _openResult = 'Unknown';
  // SnackBar _snackBar;

  // Future<void> checkAccountPermissions(Topic resource, BuildContext context) async {

  //   if(resource.category == 'Premium' && _user.membershipLevel == null){
  //     _upgradeNow();
  //     return;
  //   } else {
  //     // print('attachments: ${resource.attachments.length}');
  //     if(resource.attachments.length == 1){
  //       openAttachment(resource.attachments[0].guid as String);
  //     } else {
  //       _settingModalBottomSheet(context, resource.attachments);
  //     }
  //   }
  // }

  ListView _buildItemsForListView(BuildContext context, int index) {
      return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (BuildContext context, int index) {
        // print('TopicItemWidget index: $index');
        return InkWell(
          child: CardTopicItem(topic: _topics.elementAt(index)),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (BuildContext context) {
              return  TopicScreen(topic: _topics.elementAt(index));
            }));
          }
        );
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
    // print('list length: ${_topics.length}');
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      endDrawer: FilterWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Ask the PE-ople',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(300),
                // onTap: () {
                //   Navigator.of(context).pushNamed('/Account');
                // },
                // child: CircleAvatar(
                //   backgroundImage: NetworkImage(_profilePicture),
                // )
                // logout 
                onTap: () async {   
                  await _user.logout();
                  Navigator.of(context).pushNamed('/SignIn');
                },
                child: Icon(
                  Icons.power_settings_new,
                  color: Theme.of(context).focusColor.withOpacity(1),)
              )),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(controller: _searchQuery, hideCategoryFilter: true,), 
          ),
          const SizedBox(height: 20),
          !_isLoading && _topics.isEmpty ? EmptyResourcesWidget() : SizedBox(height: 1),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                // print('_isLoading: $_isLoading');
                // print('pixels: ${scrollInfo.metrics.pixels}');
                if (!_isLoading && scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  setState(() {
                    _isLoading = true;
                  });
                  _getDefaultList(_keyword);
                  // start loading data
                }
              },
              child: _isLoading && _topics.isEmpty ? const Center(
                child: CircularProgressIndicator(),
              ) : _buildItemsForListView(context, _topics.length)
            ),
          ),
          Container(
            height: _isLoading && _topics.length > 0 ? 50.0 : 0,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          // Flexible(child:
          //   _isLoading ? 
          //     const Center(child: CircularProgressIndicator()) 
          //   :
          //   _buildItemsForListView(context, _topics.length)),
          const SizedBox(height: 20),
        ],
      ),
  
    );
  }
}
