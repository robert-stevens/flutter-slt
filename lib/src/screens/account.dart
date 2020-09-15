import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/screens/web_view.dart';
import 'package:shareLearnTeach/src/widgets/ProfileSettingsDialog.dart';
import 'package:shareLearnTeach/src/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  User _user = User.init();

  _AccountWidgetState() {
    User().getUser().then((User val) => setState(() {
      print(val);
      _user = val;
      // _profilePicture = val.avatar;
    }));
  }

  void _openMembershipPage(){
    Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return const WebViewWebPage(title: 'Help & Support', url: 'https://sharelearnteach.com/support/');
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
        //   onPressed: () => _scaffoldKey.currentState.openDrawer(),
        // ),
        leading: IconButton(
          icon: Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Account',
          style: Theme.of(context).textTheme.display1,
        ),
        // actions: <Widget>[
        //   Container(
        //       width: 30,
        //       height: 30,
        //       margin: const EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
        //       child: InkWell(
        //         borderRadius: BorderRadius.circular(300),
        //         onTap: () {
        //           Navigator.of(context).pushNamed('/Account');
        //         },
        //         child: const CircleAvatar(
        //           backgroundImage: AssetImage('img/user2.jpg'),
        //         ),
        //       )),
        // ],
        // actions: <Widget>[
        //   Container(
        //       width: 30,
        //       height: 30,
        //       margin: const EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
        //       child: IconButton(
        //         icon: Icon(Icons.close, color: Theme.of(context).hintColor),
        //         onPressed: () => Navigator.of(context).pop(context)
        //       ),
        //   ),
        
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.close, color: Theme.of(context).hintColor),
      //       onPressed: () => Navigator.of(context).pop(context)
      //     ),
      // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: SearchBarWidget(),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          _user.displayName,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.display2,
                        ),
                        Text(
                          _user.email,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  SizedBox(
                      width: 55,
                      height: 55,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(300),
                        onTap: () {
                          // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(_user.avatar),
                        )
                      )),
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).primaryColor,
            //     borderRadius: BorderRadius.circular(6),
            //     boxShadow: [
            //       BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
            //     ],
            //   ),
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //         child: FlatButton(
            //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            //           onPressed: () {
            //             Navigator.of(context).pushNamed('/Tabs', arguments: 4);
            //           },
            //           child: Column(
            //             children: <Widget>[
            //               Icon(UiIcons.heart),
            //               Text(
            //                 'Wish List',
            //                 style: Theme.of(context).textTheme.body1,
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: FlatButton(
            //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            //           onPressed: () {
            //             Navigator.of(context).pushNamed('/Tabs', arguments: 0);
            //           },
            //           child: Column(
            //             children: <Widget>[
            //               Icon(UiIcons.favorites),
            //               Text(
            //                 'Following',
            //                 style: Theme.of(context).textTheme.body1,
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: FlatButton(
            //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            //           onPressed: () {
            //             Navigator.of(context).pushNamed('/Tabs', arguments: 3);
            //           },
            //           child: Column(
            //             children: <Widget>[
            //               Icon(UiIcons.chat_1),
            //               Text(
            //                 'Messages',
            //                 style: Theme.of(context).textTheme.body1,
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    leading: Icon(UiIcons.user_1),
                    title: Text(
                      'Profile Settings',
                      style: Theme.of(context).textTheme.body2,
                    ),
                    // trailing: ButtonTheme(
                    //   padding: EdgeInsets.all(0),
                    //   minWidth: 50.0,
                    //   height: 25.0,
                    //   child: ProfileSettingsDialog(
                    //     user: this._user,
                    //     onChanged: () {
                    //       setState(() {});
                    //     },
                    //   ),
                    // ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Full name',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    trailing: Text(
                      _user.displayName,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Email',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    trailing: Text(
                      _user.email,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {},
                  //   dense: true,
                  //   title: Text(
                  //     'Gender',
                  //     style: Theme.of(context).textTheme.body1,
                  //   ),
                  //   trailing: Text(
                  //     // _user.gender,
                  //     '',
                  //     style: TextStyle(color: Theme.of(context).focusColor),
                  //   ),
                  // ),
                  // ListTile(
                  //   onTap: () {},
                  //   dense: true,
                  //   title: Text(
                  //     'Birth Date',
                  //     style: Theme.of(context).textTheme.body1,
                  //   ),
                  //   trailing: Text(
                  //     // _user.getDateOfBirth(),
                  //     '',
                  //     style: TextStyle(color: Theme.of(context).focusColor),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    leading: Icon(UiIcons.settings_1),
                    title: Text(
                      'Account Settings',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {},
                  //   dense: true,
                  //   title: Row(
                  //     children: <Widget>[
                  //       Icon(
                  //         UiIcons.placeholder,
                  //         size: 22,
                  //         color: Theme.of(context).focusColor,
                  //       ),
                  //       SizedBox(width: 10),
                  //       Text(
                  //         'Shipping Adresses',
                  //         style: Theme.of(context).textTheme.body1,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      // Navigator.of(context).pushNamed('/Languages');
                    },
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Icon(
                          UiIcons.planet_earth,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Languages',
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ],
                    ),
                    trailing: Text(
                      'English',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _openMembershipPage();
                    },
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Icon(
                          UiIcons.information,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Help & Support',
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
