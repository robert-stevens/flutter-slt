import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/category.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/screens/post.dart';
// import 'package:shareLearnTeach/src/screens/chat.dart';
// import 'package:shareLearnTeach/src/screens/favorites.dart';
import 'package:shareLearnTeach/src/screens/tabs/activity.dart';
import 'package:shareLearnTeach/src/screens/tabs/resources.dart';
import 'package:shareLearnTeach/src/screens/tabs/ask.dart';
// import 'package:shareLearnTeach/src/screens/messages.dart';
// import 'package:shareLearnTeach/src/screens/notifications.dart';
import 'package:shareLearnTeach/src/widgets/DrawerWidget.dart';
import 'package:shareLearnTeach/src/widgets/FilterWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabsWidget extends StatefulWidget {
  int currentTab = 2;
  final List<Category> categoryList;
  int selectedTab = 2;
  String currentTitle = 'Activity';
  String postType = 'Status';
  String _profilePicture;
  User _user;
  Widget currentPage = ActivityWidget();

  TabsWidget({
    Key key,
    this.currentTab,
    this.categoryList,
  }) : super(key: key);

  @override
  _TabsWidgetState createState() {
    return _TabsWidgetState();
  }
}

class _TabsWidgetState extends State<TabsWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  initState() {
    _selectTab(widget.currentTab);
    super.initState();

    User().getUser().then((User val) => setState(() {
          widget._user = val;
          widget._profilePicture = val.avatar;
        }));
  }

  @override
  void didUpdateWidget(TabsWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      widget.selectedTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentTitle = 'Activity';
          widget.postType = 'Status';
          widget.currentPage = ActivityWidget(user: widget._user);
          break;
        case 1:
          widget.currentTitle = 'Resources';
          widget.postType = 'Resource';
          widget.currentPage = ResourcesWidget(
            user: widget._user,
            categoryList: widget.categoryList,
          );
          break;
        case 2:
          widget.currentTitle = 'Ask the PE-ople';
          widget.postType = 'Topic';
          widget.currentPage = ForumsScreen(
            user: widget._user,
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      endDrawer: FilterWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.currentTitle,
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            child: widget._user != null
                ? InkWell(
                    borderRadius: BorderRadius.circular(300),
                    onTap: () {
                      Navigator.of(context).pushNamed('/Account');
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget._profilePicture),
                    ))
                : null,
          )
        ],
      ),
      body: widget.currentPage,
      floatingActionButton: new FloatingActionButton(
          // elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () async {
            var isLoggedIn = await User().isLoggedIn(context);
            if (!isLoggedIn) {
              return;
            }
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostWidget(postType: widget.postType),
              ),
            );
            setState(() {
              widget.currentPage = ActivityWidget(user: widget._user);
            });
          }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 22,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(size: 25),
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
        currentIndex: widget.selectedTab,
        onTap: (int i) {
          this._selectTab(i);
        },
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            title: new Container(height: 0.0),
            icon: widget.currentTab == 0
                ? Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(0.8),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            blurRadius: 40,
                            offset: Offset(0, 15)),
                        BoxShadow(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            blurRadius: 13,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: new Icon(UiIcons.home,
                        color: Theme.of(context).primaryColor),
                  )
                : Icon(UiIcons.home),
          ),
          BottomNavigationBarItem(
            title: new Container(height: 0.0),
            icon: widget.currentTab == 1
                ? Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(0.8),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            blurRadius: 40,
                            offset: Offset(0, 15)),
                        BoxShadow(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            blurRadius: 13,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: new Icon(UiIcons.file_1,
                        color: Theme.of(context).primaryColor),
                  )
                : Icon(UiIcons.file_1),
          ),
          BottomNavigationBarItem(
            title: new Container(height: 5.0),
            icon: widget.currentTab == 2
                ? Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(0.8),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            blurRadius: 40,
                            offset: Offset(0, 15)),
                        BoxShadow(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            blurRadius: 13,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: new Icon(UiIcons.chat,
                        color: Theme.of(context).primaryColor),
                  )
                : Icon(UiIcons.chat),
          ),
        ],
      ),
    );
  }
}
