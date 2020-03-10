import 'package:listing/config/ui_icons.dart';
import 'package:listing/src/models/category.dart';
import 'package:listing/src/models/utilities.dart';
import 'package:listing/src/widgets/FavoriteListItemWidget.dart';
import 'package:listing/src/widgets/UtilitiesGridItemWidget.dart';
import 'package:listing/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// ignore: must_be_immutable
class UtilitiesByBrandWidget extends StatefulWidget {
  Category category;

  UtilitiesByBrandWidget({Key key, this.category}) : super(key: key);

  @override
  _UtilitiesByBrandWidgetState createState() => _UtilitiesByBrandWidgetState();
}

class _UtilitiesByBrandWidgetState extends State<UtilitiesByBrandWidget> {
  String layout = 'grid';
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SearchBarWidget(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              '${widget.category.name} Items',
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
                      this.layout = 'list';
                    });
                  },
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: this.layout == 'list' ? Theme.of(context).focusColor : Theme.of(context).focusColor.withOpacity(0.4),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      this.layout = 'grid';
                    });
                  },
                  icon: Icon(
                    Icons.apps,
                    color: this.layout == 'grid' ? Theme.of(context).focusColor : Theme.of(context).focusColor.withOpacity(0.4),
                  ),
                )
              ],
            ),
          ),
        ),
        Offstage(
          offstage: this.layout != 'list',
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: widget.category.utilities.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return FavoriteListItemWidget(
                heroTag: 'Utilities_by_category_list',
                utilitie: widget.category.utilities.elementAt(index),
                onDismissed: () {
                  setState(() {
                    widget.category.utilities.removeAt(index);
                  });
                },
              );
            },
          ),
        ),
        Offstage(
          offstage: this.layout != 'grid',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: new StaggeredGridView.countBuilder(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 4,
              itemCount: widget.category.utilities.length,
              itemBuilder: (BuildContext context, int index) {
                Utilitie utilitie = widget.category.utilities.elementAt(index);
                return UtilitietGridItemWidget(
                  utilitie: utilitie,
                  heroTag: 'Utilities_by_category_grid',
                );
              },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
