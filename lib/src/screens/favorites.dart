import 'package:listing/config/ui_icons.dart';
import 'package:listing/src/models/utilities.dart';
import 'package:listing/src/widgets/EmptyFavoritesWidget.dart';
import 'package:listing/src/widgets/FavoriteListItemWidget.dart';
import 'package:listing/src/widgets/UtilitiesGridItemWidget.dart';
import 'package:listing/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  String layout = 'list';
  final UtilitiesList _utilitiesList = UtilitiesList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),
          const SizedBox(height: 10),
          Offstage(
            offstage: _utilitiesList.favoritesList.isEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                leading: Icon(
                  UiIcons.heart,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Wish List',
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: Theme.of(context).textTheme.display1,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          layout = 'list';
                        });
                      },
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: layout == 'list' ? Theme.of(context).focusColor: Theme.of(context).focusColor.withOpacity(0.4),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          layout = 'grid';
                        });
                      },
                      icon: Icon(
                        Icons.apps,
                        color: layout == 'grid' ? Theme.of(context).focusColor: Theme.of(context).focusColor.withOpacity(0.4),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Offstage(
            offstage: layout != 'list' || _utilitiesList.favoritesList.isEmpty,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: _utilitiesList.favoritesList.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return FavoriteListItemWidget(
                  heroTag: 'favorites_list',
                  utilitie: _utilitiesList.favoritesList.elementAt(index),
                  onDismissed: () {
                    setState(() {
                      _utilitiesList.favoritesList.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
          Offstage(
            offstage: layout != 'grid' || _utilitiesList.favoritesList.isEmpty,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: StaggeredGridView.countBuilder(
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: _utilitiesList.favoritesList.length,
                itemBuilder: (BuildContext context, int index) {
                  final Utilitie utilitie = _utilitiesList.favoritesList.elementAt(index);
                  return UtilitietGridItemWidget(
                    utilitie: utilitie,
                    heroTag: 'favorites_grid',
                  );
                },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ),
            ),
          ),
          Offstage(
            offstage: _utilitiesList.favoritesList.isNotEmpty,
            child: const EmptyFavoritesWidget(),
          )
        ],
      ),
    );
  }
}
