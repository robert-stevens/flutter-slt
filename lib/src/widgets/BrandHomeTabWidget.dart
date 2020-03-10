import 'package:listing/config/ui_icons.dart';
import 'package:listing/src/models/category.dart';
import 'package:listing/src/models/utilities.dart';
import 'package:listing/src/widgets/PopularLocationCarouselWidget.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class BrandHomeTabWidget extends StatefulWidget {
  Category category;
  UtilitiesList _utilitiesList = new UtilitiesList();

  BrandHomeTabWidget({this.category});

  @override
  _BrandHomeTabWidgetState createState() => _BrandHomeTabWidgetState();
}

class _BrandHomeTabWidgetState extends State<BrandHomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /*Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),

          child: Center(
            child: Text(
              '${widget.category.name}',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),*/
        Padding( 
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.favorites,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Description',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
              'We’re all going somewhere. And whether it’s the podcast blaring from your headphones as you walk down the street or the essay that encourages you to take on that big project, there’s a real joy in getting lost in the kind of story that feels like a destination unto itself.'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.trophy,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Popular',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        PopularLocationCarouselWidget(heroTag: 'brand_featured_products', utilitiesList: widget._utilitiesList.popularList),
      ],
    );
  }
}
