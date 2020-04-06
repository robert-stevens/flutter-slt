import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function onSearch;

  const SearchBarWidget({
    Key key,
    this.onSearch
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: const Offset(0, 4), blurRadius: 10)
        ],
      ),
      child:Column(
        children: <Widget>[
            Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8)),
                    prefixIcon: Icon(UiIcons.loupe, size: 20, color: Theme.of(context).hintColor),
                    border:  const UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onChanged: onSearch
                ),
                IconButton(
                  onPressed: () async {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(UiIcons.settings_2, size: 20, color: Theme.of(context).hintColor.withOpacity(0.5)),
                ),
              ],
            ),
        ],
      ), 
    );
  }
}
