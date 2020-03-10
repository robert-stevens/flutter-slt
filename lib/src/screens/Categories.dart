import 'package:listing/src/models/category.dart';
import 'package:listing/src/widgets/BrandGridWidget.dart';
import 'package:listing/src/widgets/DrawerWidget.dart';
import 'package:listing/src/widgets/SearchBarWidget.dart';
import 'package:listing/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CategoriesList _categoriesList = new CategoriesList();
  SubCategoriesList _subCategoriesList = new SubCategoriesList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          //new ShoppingCartButtonWidget(
             // iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SearchBarWidget(),
            ),
            BrandGridWidget(categoriesList: _categoriesList),
          ],
        ),
      ),
    );
  }
}
