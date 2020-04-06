import 'package:shareLearnTeach/src/models/utilities.dart';
import 'package:shareLearnTeach/src/widgets/PopularLocationCarouselItemWidget.dart';
import 'package:flutter/material.dart';

class PopularLocationCarouselWidget extends StatelessWidget {
  List<Utilitie> utilitiesList;
  String heroTag;

  PopularLocationCarouselWidget({
    Key key,
    this.utilitiesList,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: utilitiesList.length,
          itemBuilder: (context, index) {
            double _marginLeft = 0;
            (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
            return PopularLocationCarouselItemWidget(
              heroTag: this.heroTag,
              marginLeft: _marginLeft,
              utilitie: utilitiesList.elementAt(index),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
