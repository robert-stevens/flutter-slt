import 'package:listing/src/models/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'UtilitiesRelateItemWidget.dart';

class CategorizedUtilitiesWidget extends StatelessWidget {
  const CategorizedUtilitiesWidget({
    Key key,
    @required this.animationOpacity,
    @required List<Utilitie> utilitiesList,
  })  : _utilitiesList = utilitiesList,
        super(key: key);

  final Animation animationOpacity;
  final List<Utilitie> _utilitiesList;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationOpacity,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: new StaggeredGridView.countBuilder(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 1,
          itemCount: _utilitiesList.length,
          itemBuilder: (BuildContext context, int index) {
            Utilitie utilitie = _utilitiesList.elementAt(index);
            return UtilitieRelateItemWidget(
              utilitie: utilitie,
              heroTag: 'categorized_utilities_grid',
            );
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        ),
      ),
    );
  }
}
