import 'package:listing/src/models/category.dart';
// import 'package:listing/src/models/product_color.dart';
import 'package:listing/src/models/route_argument.dart';
import 'package:flutter/material.dart';


class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final CategoriesList _categoriesList = CategoriesList();
  // final ProductColorsList _productColorsList = ProductColorsList();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Refine Results'),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        clearSelection();
                      });
                    },
                    child: Text(
                      'Clear',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                primary: true,
                shrinkWrap: true,
                children: <Widget>[
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                        'Categories',
                    ),
                    children: List.generate(6, (index) {
                      var _category = _categoriesList.list.elementAt(index);
                      return CheckboxListTile(
                        value: _category.selected,
                        onChanged: (value) {
                          setState(() {
                            _category.selected = value;
                          });
                        },
                        secondary: Container(
                          width: 35,
                          height: 35,
                          child: Icon(
                            _category.icon,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          _category.name,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      );
                    }),
                  ),
                  // ExpansionTile(
                  //   initiallyExpanded: true,
                  //   title: Text('Colors'),
                  //   children: List.generate(5, (index) {
                  //     var _color = _productColorsList.list.elementAt(index);
                  //     return CheckboxListTile(
                  //       value: _color.selected,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           _color.selected = value;
                  //         });
                  //       },
                  //       secondary: Container(
                  //         width: 35,
                  //         height: 35,
                  //         decoration: BoxDecoration(
                  //           color: _color.color,
                  //           shape: BoxShape.circle,
                  //         ),
                  //       ),
                  //       title: Text(
                  //         _color.name,
                  //         overflow: TextOverflow.fade,
                  //         softWrap: false,
                  //         maxLines: 1,
                  //       ),
                  //     );
                  //   }),
                  // ),
                  
                ],
              ),
            ),
            const SizedBox(height: 15),
            FlatButton(
              onPressed: () {
                // Navigator.of(context).pushNamed('/Resources',
                //     arguments: RouteArgument(id: 2, argumentsList: [CategoriesList().list.elementAt(0)]));
                Navigator.of(context).pop(context);
              },
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              color: Theme.of(context).accentColor,
              shape: const StadiumBorder(),
              child: Text(
                'Apply Filters',
                textAlign: TextAlign.start,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  void clearSelection() {
    _categoriesList.clearSelection();
  }
}
