import 'package:flutter/material.dart';
import 'package:shareLearnTeach/src/models/category.dart';
import 'package:shareLearnTeach/src/screens/resources.dart';
// import 'package:shareLearnTeach/src/models/route_argument.dart';
// import 'package:shareLearnTeach/src/services/wordpress.dart';

// You can pass any object to the arguments parameter.
// In this example, create a class that contains a customizable
// title and message.
class ScreenArguments {
  ScreenArguments(this.list);

  final List<Category>  list;
}

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {

  @override
  void initState() {
    super.initState();
    _getCategories(); 
  }

  List<Category> _categoryList = <Category>[]; 
  

  void _getCategories() async {
    final List<Category> categoriesList = await Category.getCategoryList();

    categoriesList.removeWhere((Category item) => item.name == 'Uncategorized');
    setState(() => {
      _categoryList = categoriesList
    });
  }

  void selectById(String id) {
    _categoryList.map((Category category) {
      category.selected = false;
      if (category.id == id) {
        category.selected = true;
      }
    });
  }

  void clearSelection() {
    _categoryList.map((Category category) {
      category.selected = false;
    });
  }

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
                    title: const Text(
                        'Categories',
                    ),
                    children: List<CheckboxListTile>.generate(_categoryList.length, (int index) {
                      final Category _category = _categoryList.elementAt(index);
                      return CheckboxListTile(
                        value: _category.selected,
                        onChanged: (bool value) {
                          setState(() {
                            _category.selected = value;
                          });
                        },
                        secondary: Container(
                          width: 55,
                          height: 35,
                          // child: Icon(
                          //   _category.icon,
                          //   color: Colors.black,
                          // ),
                          child: Chip(label: Text('${_category.count}'),)
                        ),
                        title: Text(
                          '${_category.name}',
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      );
                    }),
                  ),
                  
                ],
              ),
            ),
            const SizedBox(height: 15),
            FlatButton(
              onPressed: () {
                // Navigator.of(context).popAndPushNamed('/Resources');
                // Navigator.of(context).popAndPushNamed('/Resources', arguments: {'categoriesList': _categoryList}, );
                // Navigator.of(context).pop(context);
                
                // Navigator.of(context).popAndPushNamed('/Resources',
                //   arguments: ScreenArguments(_categoryList));

                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => ResourcesWidget(
                      categoryList: _categoryList,
                    )),
                );
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
}
