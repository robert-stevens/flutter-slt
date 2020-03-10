import 'package:listing/src/models/category.dart';
import 'package:listing/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BrandGridWidget extends StatelessWidget {
  const BrandGridWidget({
    Key key,
    @required CategoriesList categoriesList,
  })  : _categoriesList = categoriesList,
        super(key: key);

  final CategoriesList _categoriesList;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 15),
      crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
      itemCount: _categoriesList.list.length,
      itemBuilder: (BuildContext context, int index) {
        Category category = _categoriesList.list.elementAt(index);
        return InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/Categorie', arguments: new RouteArgument(id: category.id, argumentsList: [category]));
          },
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                alignment: AlignmentDirectional.topCenter,
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
                    ],
                    gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                      category.color,
                      category.color.withOpacity(0.2),
                    ])),
                child: Hero(
                  tag: category.id,
                  child: new Icon(
                    category.icon,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                  ),
                ),
              ),
              Positioned(
                right: -50,
                bottom: -100,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                top: -60,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 80, bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: 140,
                height: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      category.name,
                      style: Theme.of(context).textTheme.body2,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                    Row(
                      children: <Widget>[
                        // The title of the product
                        Expanded(
                          child: Text(
                            '${category.utilities.length} Items',
                            style: Theme.of(context).textTheme.body1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
    );
  }
}
