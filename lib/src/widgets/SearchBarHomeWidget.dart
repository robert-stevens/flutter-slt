import 'package:listing/config/ui_icons.dart';
import 'package:flutter/material.dart';

class SearchBarHomeWidget extends StatelessWidget {
  SearchBarHomeWidget({
    Key key,
  }) : super(key: key);
  List<String> suggestions=["Delux Room","Tripple Room","Single Room","King Room"];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
        ],
      ),
      child:Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.4),width: 1),
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8)),
                    prefixIcon: Icon(UiIcons.loupe, size: 20, color: Theme.of(context).hintColor),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(UiIcons.settings_2, size: 20, color: Theme.of(context).hintColor.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: _buildSuggestions(suggestions,context),
          )
        ],
      ),
       
    );
  }
}
  _buildSuggestions(List<String> list,BuildContext context) {
    List<Widget> choices = List();
    list.forEach((item) {
      choices.add(
        Container(
          margin: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).hintColor.withOpacity(0.2),
            ),
            padding: const EdgeInsets.only(left:10.0,right: 10,top: 3,bottom: 3),
            child: Text(
              item,
              style: Theme.of(context).textTheme.body1.merge(TextStyle(color: Theme.of(context).primaryColor),),
            
            ),
          ),
        ),
      );
    }
    );return choices;
  }