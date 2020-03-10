import 'package:listing/config/ui_icons.dart';
import 'package:listing/src/models/utilities.dart';
import 'package:listing/src/models/route_argument.dart';
import 'package:listing/src/widgets/DrawerWidget.dart';
import 'package:listing/src/widgets/UtilitiesHomeTabWidget.dart';
import 'package:listing/src/widgets/ReviewsListWidget.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class UtilitieWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Utilitie _utilitie;
  String _heroTag;

  UtilitieWidget({Key key, this.routeArgument}) {
    _utilitie = this.routeArgument.argumentsList[0] as Utilitie;
    _heroTag = this.routeArgument.argumentsList[1] as String;
  }

  @override
  _UtilitieWidgetState createState() => _UtilitieWidgetState();
}

class _UtilitieWidgetState extends State<UtilitieWidget> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      bottomNavigationBar:BottomAppBar(
        elevation: 0,
        child: Container(
          height: 20,
        ),),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          floating: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            //new ShoppingCartButtonWidget(
                //iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
            Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(300),
                  onTap: () {
                    Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('img/user2.jpg'),
                  ),
                )),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          expandedHeight: 350,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Hero(
              tag: widget._heroTag + widget.routeArgument.id,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget._utilitie.image),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                      Theme.of(context).primaryColor,
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0),
                      Theme.of(context).scaffoldBackgroundColor
                    ], stops: [
                      0,
                      0.4,
                      0.6,
                      1
                    ])),
                  ),
                ],
              ),
            ),
          ),
          bottom: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              unselectedLabelColor: Theme.of(context).focusColor.withOpacity(1),
              labelColor: Theme.of(context).primaryColor,
              indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).focusColor.withOpacity(0.6)),
              tabs: [
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        //border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.6), width: 1)
                        ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Detail"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        //border: Border.all(color: Theme.of(context).focusColor.withOpacity(0.2), width: 1)
                        ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Review"),
                    ),
                  ),
                ),
              ]),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Offstage(
              offstage: 0 != _tabIndex,
              child: Column(
                children: <Widget>[
                  UtilitieHomeTabWidget(utilitie: widget._utilitie),
                ],
              ),
            ),
            Offstage(
              offstage: 1 != _tabIndex,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.chat_1,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Reviews',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  ReviewsListWidget()
                ],
              ),
            )
          ]),
        )
      ]),
    );
  }
}
