import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/screens/signin.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  _DrawerWidgetState() {
    User().getUser().then((User val) => setState(() {
          _user = val;
        }));
  }

  User _user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _user != null
              ? GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                    Navigator.of(context).pop(context);
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    accountName: Text(
                      _user.displayName,
                      style: Theme.of(context).textTheme.title,
                    ),
                    accountEmail: Text(
                      _user.email,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      backgroundImage: NetworkImage(_user.avatar),
                    ),
                  ),
                )
              : FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.7,
                  child: Container(
                      child: Image.asset(
                        'img/logo.png',
                      ),
                      padding: EdgeInsets.only(bottom: 10))),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 0);
            },
            leading: Icon(
              UiIcons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Activity Feed',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              UiIcons.file_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Resources',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 2);
            },
            leading: Icon(
              UiIcons.chat,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Ask the PE-ople',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Jobs');
          //   },
          //   leading: Icon(
          //     UiIcons.home,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Job Bulletin',
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 2);
          //   },
          //   leading: Icon(
          //     UiIcons.home,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Home',
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 0);
          //   },
          //   leading: Icon(
          //     UiIcons.bell,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Notifications',
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 4);
          //   },
          //   leading: Icon(
          //     UiIcons.heart,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Wish List",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Categories');
          //   },
          //   leading: Icon(
          //     UiIcons.folder_1,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Categories",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //   },
          //   leading: Icon(
          //     UiIcons.settings_1,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Settings",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Languages');
          //   },
          //   leading: Icon(
          //     UiIcons.planet_earth,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Languages",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          _user != null
              ? ListTile(
                  onTap: () async {
                    await _user.logout();
                    Navigator.of(context)
                        .popAndPushNamed('/Tabs', arguments: 0);
                  },
                  leading: Icon(
                    UiIcons.upload,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'Sign out',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                )
              : ListTile(
                  onTap: () async {
                    // Navigator.of(context).pushNamed('/SignIn');
                    // Navigator.pushNamed(context, '/SignIn');

                    Navigator.of(context).push(_createRoute());
                  },
                  leading: Icon(
                    UiIcons.upload,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'Sign in',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                )
          /*ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),*/
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignInWidget(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
