import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shareLearnTeach/src/widgets/DrawerWidget.dart';
import 'package:shareLearnTeach/src/models/resource.dart';
// import 'package:shareLearnTeach/src/models/route_argument.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/models/category.dart';
import 'package:shareLearnTeach/src/screens/web_view.dart';
import 'package:shareLearnTeach/src/widgets/FilterWidget.dart';
import 'package:shareLearnTeach/src/widgets/ResourceItemWidget.dart';
import 'package:shareLearnTeach/src/widgets/SearchBarWidget.dart';
import 'package:shareLearnTeach/src/widgets/EmptyResourcesWidget.dart';

class ResourcesWidget extends StatefulWidget {

  ResourcesWidget({Key key, this.categoryList});

  final List<Category> categoryList;

  @override
  _ResourcesWidgetState createState() => _ResourcesWidgetState();
}

class _ResourcesWidgetState extends State<ResourcesWidget> {

  _ResourcesWidgetState() {
    User().getUser().then((User val) => setState(() {
      _user = val;
      _profilePicture = val.avatar;
    }));
  }

  @override
  void initState() {
    super.initState();
    _getDefaultList(_keyword); 
  }

  void onSearch(String value) {
    // print('keyword: $value');
    if(value.length > 3)
      setState(() => {
        _isLoading = true
      });
      _getDefaultList(value);
  }

  Future<void> _getDefaultList(String keyword) async {

    // perform fetching data delay
    // await Future<dynamic>.delayed(const Duration(seconds: 2));
    // print('category list: ${widget.categoryList}');
    // print('keyword $keyword');
    if(_keyword != keyword){
      setState(() {
        _resourcesList = <Resource>[];
        _keyword = keyword;
      });
    }
    final List<Resource> newItems = await Resource.getResources(widget.categoryList, _keyword, _resourcesList.length, incrementCount);
    // print('resourcesList length: ${_resourcesList.length}');
    // print('newItems length: ${newItems.length}');

    if (_resourcesList == null || _resourcesList.isEmpty){
      _resourcesList = newItems;
    } else {
      _resourcesList.addAll( newItems);
    }

    setState(() => {
      _resourcesList = _resourcesList,
      _isLoading = false
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Resource> _resourcesList = <Resource>[]; 
  String layout = 'list';
  bool _isLoading = true;

  User _user;
  String _profilePicture;
  String _keyword = '';
  int incrementCount = 10;
  // String _openResult = 'Unknown';
  // SnackBar _snackBar;

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

  Future<void> checkAccountPermissions(Resource resource, BuildContext context) async {

    if(resource.category == 'Premium' && _user.membershipLevel == null){
      _upgradeNow();
      return;
    } else {
      // print('attachments: ${resource.attachments.length}');
      if(resource.attachments.length == 1){
        openAttachment(resource.attachments[0].guid as String);
      } else {
        _settingModalBottomSheet(context, resource.attachments);
      }
    }
  }

  void _settingModalBottomSheet(BuildContext context, dynamic attachments){
      // print('attachments: ${attachments.length}');
      showModalBottomSheet<dynamic>(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  title: const Text('Attachments:'),
                ),
                ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (BuildContext context, int index) {
                    // print('ResourceItemWidget index: $index');
                    return ListTile(
                      leading: Icon(Icons.attach_file),
                      title: Text(attachments[index].title as String),
                      onTap: () => openAttachment(attachments[index].guid as String)          
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemCount: attachments.length as int,
                  primary: false,
                  shrinkWrap: true,
                ),
                Container(height: 50),
              ],
            ),
          );
        }
      );
  }

  void _openMembershipPage(){
    Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return const WebViewWebPage(title: 'Upgrade Now', url: 'https://sharelearnteach.com/membership-account/membership-levels/');
    }));
  }

  Future<void> _upgradeNow() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Premium Account Needed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('To download attachments from resources you need a premium account.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('Upgrade Now'),
              onPressed: () {
                Navigator.of(context).pop();
                _openMembershipPage();
              },
            ),
          ],
        );
      },
    );
  }

  ListView _buildItemsForListView(BuildContext context, int index) {
      return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (BuildContext context, int index) {
        // print('ResourceItemWidget index: $index');
        return ResourceItemWidget(resource: _resourcesList.elementAt(index), checkAccountPermissions: checkAccountPermissions);
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
    // print('list length: ${_resourcesList.length}');
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
                // onTap: () async {   
                //   await _user.logout();
                //   Navigator.of(context).pushNamed('/SignIn');
                // },
                // child: Icon(
                //   Icons.power_settings_new,
                //   color: Theme.of(context).focusColor.withOpacity(1),)
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
            child: SearchBarWidget(onSearch: onSearch), 
          ),
          const SizedBox(height: 20),
          !_isLoading && _resourcesList.isEmpty ? EmptyResourcesWidget() : SizedBox(height: 1),
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
              child: _isLoading && _resourcesList.isEmpty ? const Center(
                child: CircularProgressIndicator(),
              ) : _buildItemsForListView(context, _resourcesList.length)
            ),
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
