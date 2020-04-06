import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/utilities.dart';
import 'package:shareLearnTeach/src/models/route_argument.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FavoriteListItemWidget extends StatefulWidget {
  String heroTag;
  Utilitie utilitie;
  VoidCallback onDismissed;

  FavoriteListItemWidget({Key key, this.heroTag, this.utilitie, this.onDismissed}) : super(key: key);

  @override
  _FavoriteListItemWidgetState createState() => _FavoriteListItemWidgetState();
}

class _FavoriteListItemWidgetState extends State<FavoriteListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.utilitie.hashCode.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              UiIcons.trash,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        // Remove the item from the data source.
        setState(() {
          widget.onDismissed();
        });

        // Then show a snackbar.
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("The ${widget.utilitie.name} utilitie is removed from wish list")));
      },
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.of(context).pushNamed('/Utilities',
              arguments: RouteArgument(
                  argumentsList: [this.widget.utilitie, this.widget.heroTag], id: this.widget.utilitie.id));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: widget.heroTag + widget.utilitie.id,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(image: AssetImage(widget.utilitie.image), fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.utilitie.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          Row(
                            children: <Widget>[
                              // The title of the utilitie
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4,),
                              Text(
                                widget.utilitie.rate.toString(),
                                style: Theme.of(context).textTheme.body2,
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('${widget.utilitie.available} viewers', style: Theme.of(context).textTheme.display1),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
