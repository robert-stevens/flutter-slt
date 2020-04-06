import 'package:shareLearnTeach/src/models/utilities.dart';
import 'package:shareLearnTeach/src/models/route_argument.dart';
import 'package:flutter/material.dart';

class UtilitieRelateItemWidget extends StatelessWidget {
  const UtilitieRelateItemWidget({
    Key key,
    @required this.utilitie,
    @required this.heroTag,
  }) : super(key: key);

  final Utilitie utilitie;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Utilities',
            arguments: new RouteArgument(argumentsList: [this.utilitie, this.heroTag], id: this.utilitie.id));
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              width: 100,
              height: 100,
              child: Hero(
                tag: this.heroTag + utilitie.id,
                child: Image.asset(utilitie.image,fit: BoxFit.cover,),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    utilitie.name,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    utilitie.type,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                SizedBox(height:6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: <Widget>[
                      Text(
                        utilitie.rate.toString(),
                        style: Theme.of(context).textTheme.body2,
                      ),
                      SizedBox(width:6),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
