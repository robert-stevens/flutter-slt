import 'dart:async';

import 'package:listing/config/ui_icons.dart';
import 'package:listing/src/models/utilities.dart';
import 'package:listing/src/widgets/EmptyFavoritesWidget.dart';
import 'package:listing/src/widgets/FavoriteListItemWidget.dart';
import 'package:listing/src/widgets/ResourcesListWidget.dart';
import 'package:listing/src/widgets/UtilitiesGridItemWidget.dart';
import 'package:listing/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:listing/src/widgets/DrawerWidget.dart';
import 'package:listing/src/widgets/FilterWidget.dart';
import 'package:listing/src/models/user.dart';

class ResourcesWidget extends StatefulWidget {
  @override
  _ResourcesWidgetState createState() => _ResourcesWidgetState();
}

class _ResourcesWidgetState extends State<ResourcesWidget> {

  _ResourcesWidgetState() {
    User().getUser().then((val) => setState(() {
      _profilePicture = val.avatar;
    }));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String layout = 'list';
  final UtilitiesList _utilitiesList = UtilitiesList();
  bool loading = true;

  User _user;
  String _profilePicture;

  @override
  Widget build(BuildContext context) {
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
          'Resources',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(300),
                onTap: () {
                  Navigator.of(context).pushNamed('/Account');
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_profilePicture),
                )
              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const SearchBarWidget(),
          ),
          const SizedBox(height: 20),
          // Offstage(
          //   offstage: _utilitiesList.favoritesList.isEmpty,
          //   child: ResourcesListWidget()
          // ),
          // Offstage(
          //   offstage: _utilitiesList.favoritesList.isNotEmpty,
          //   child: const EmptyFavoritesWidget(),
          // ),
          ResourcesListWidget(),
          const SizedBox(height: 100),
        ],
      ),
      ),
    );
  }
}
