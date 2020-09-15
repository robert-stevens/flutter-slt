import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/activity.dart';
import 'package:shareLearnTeach/src/models/category.dart';
import 'package:shareLearnTeach/src/models/resource.dart';
import 'package:shareLearnTeach/src/models/topic.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';

// ignore: must_be_immutable
class PostWidget extends StatefulWidget {
  String postType = 'Resource';

  PostWidget({
    Key key,
    this.postType,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  User _user = User.init();
  List<Category> _categories;
  String dropdownValue = 'Status';
  String title = '';
  String description = '';
  bool _isLoading = false;

  String _fileName;
  String _path;
  Map<String, String> _paths;
  bool _loadingPath = false;
  bool _multiPick = true;
  String _selectedCategory;
  FileType _pickingType = FileType.any;

  @override
  initState() {
    super.initState();
    User().getUser().then((User val) => setState(() {
          _user = val;
          dropdownValue = widget.postType;
        }));

    Category.getCategoryList().then((List<Category> categories) => setState(() {
          _categories = categories;
          _selectedCategory = _categories[0].id.toString();
        }));
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      if (_multiPick) {
        _path = null;
        _paths = await FilePicker.getMultiFilePath(
          type: _pickingType,
        );
      } else {
        _paths = null;
        _path = await FilePicker.getFilePath(
            type: _pickingType,
            allowedExtensions: [
              'jpg',
              'jpeg',
              'bmp',
              'pdf',
              'doc',
              'docx',
              'xls',
              'xlsx',
              'ppt',
              'pptx'
            ]);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }

  post(context) async {
    setState(() {
      _isLoading = true;
    });
    if (dropdownValue == 'Status') {
      await Activity.createStatus(title);
      Navigator.of(context).popAndPushNamed('/');
    }
    if (dropdownValue == 'Topic') {
      await Topic.postTopic(title, description);
      Navigator.of(context).popAndPushNamed('/Tabs', arguments: 2);
    }
    if (dropdownValue == 'Resource') {
      await Resource.post(title, description, _paths, _selectedCategory);
      Navigator.of(context).popAndPushNamed('/Tabs', arguments: 1);
    }
  }

  Widget _titleRow() {
    return (Container(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 60,
              height: 60,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child:
                      CircleAvatar(backgroundImage: NetworkImage(_user.avatar)),
                ),
                elevation: 12.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              )),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              autofocus: true,
              controller: _controller,
              keyboardType: TextInputType.multiline,
              onChanged: (value) => setState(() {
                title = value;
              }),
              maxLines: null,
              // expands: true,
              decoration: InputDecoration(
                  // contentPadding: EdgeInsets.only(top: 20),
                  hintText: "Title",
                  hintStyle: Theme.of(context).textTheme.subhead,
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _descriptionRow() {
    if (dropdownValue == 'Topic' || dropdownValue == 'Resource') {
      return (TextField(
        keyboardType: TextInputType.multiline,
        onChanged: (value) => setState(() {
          description = value;
        }),
        maxLines: null,
        // expands: true,
        decoration: InputDecoration(
            // contentPadding: EdgeInsets.only(top: 20),
            hintText: "Description",
            hintStyle: Theme.of(context).textTheme.subhead,
            border: InputBorder.none),
      ));
    }
    return Container();
  }

  Widget _resourcesActions() {
    return (Container(
        width: MediaQuery.of(context).size.width * 0.84,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: FlatButton(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    onPressed: () => _openFileExplorer(),
                    child: new Text("Select Resources"),
                    color: Theme.of(context).focusColor,
                    textColor: Colors.white,
                    shape: const StadiumBorder(),
                  )),
              SizedBox(width: 10.0),
              _categories != null
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.41,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).focusColor,
                              borderRadius: BorderRadius.circular(20)),
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            dropdownColor: Theme.of(context).accentColor,
                            iconEnabledColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            underline: Container(),
                            items: _categories.map((Category category) {
                              return new DropdownMenuItem<String>(
                                value: category.id.toString(),
                                child: new Text(category.name),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                _selectedCategory = newValue;
                              });
                            },
                          )))
                  : Container(),
            ])));
  }

  Widget _attachmentsList() {
    if (dropdownValue == 'Resource' && _paths != null && _paths.isNotEmpty) {
      return (Column(children: <Widget>[
        Container(
            child: Text("Selected Resources"), alignment: Alignment.center),
        Container(
          height: 75.00 * (_paths.length + 1),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: false,
            itemCount: _paths != null && _paths.isNotEmpty ? _paths.length : 1,
            itemBuilder: (BuildContext context, int index) {
              final bool isMultiPath = _paths != null && _paths.isNotEmpty;
              final String name = 'File $index: ' +
                  (isMultiPath
                      ? _paths.keys.toList()[index]
                      : _fileName ?? '...');
              final path = isMultiPath
                  ? _paths.values.toList()[index].toString()
                  : _path;

              return new ListTile(
                title: new Text(
                  name,
                ),
                subtitle: new Text(path),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                new Divider(),
          ),
        )
      ]));
    }
    return Container();
  }

  Widget _bodyLayout() {
    return (Column(children: <Widget>[
      _titleRow(),
      _descriptionRow(),
      _attachmentsList()
    ]));
  }

  Widget _submitBtn() {
    return (KeyboardAttachable(
        child: Container(
      margin: EdgeInsets.all(10.0),
      height: 40,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: FlatButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                onPressed: () {
                  post(context);
                },
                child: Text('Send'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                shape: const StadiumBorder(),
              )),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: DrawerWidget(),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon:
                  Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
              onPressed: () => Navigator.of(context).pop(context),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Container(
                  margin:
                      const EdgeInsets.only(top: 14.5, bottom: 10.5, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      dropdownColor: Theme.of(context).accentColor,
                      iconEnabledColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      underline: Container(),
                      items: <String>['Status', 'Resource', 'Topic']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )),
            ]),
        // body: _submitBtn()
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: FooterLayout(
              footer: dropdownValue == 'Resource'
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[_resourcesActions(), _submitBtn()],
                    )
                  : _submitBtn(),
              // footer: _submitBtn(),
              child: SingleChildScrollView(child: _bodyLayout()),
            ))
        // body: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        //     child: _bodyLayout()

        // SingleChildScrollView(
        //     child: ConstrainedBox(
        //         constraints: BoxConstraints(
        //             minHeight: MediaQuery.of(context).size.height * 0.44),
        //         child: IntrinsicHeight(
        //             child: Column(
        //           children: <Widget>[
        //             Container(
        //               child: Row(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: <Widget>[
        //                   SizedBox(
        //                       width: 60,
        //                       height: 60,
        //                       child: Card(
        //                         child: Container(
        //                           padding: EdgeInsets.all(5),
        //                           child: CircleAvatar(
        //                               backgroundImage:
        //                                   NetworkImage(_user.avatar)),
        //                         ),
        //                         elevation: 12.0,
        //                         shape: CircleBorder(),
        //                         clipBehavior: Clip.antiAlias,
        //                       )),
        //                   SizedBox(width: 10),
        //                   Expanded(
        //                     child: TextField(
        //                       autofocus: true,
        //                       controller: _controller,
        //                       keyboardType: TextInputType.multiline,
        //                       onChanged: (value) => setState(() {
        //                         title = value;
        //                       }),
        //                       maxLines: null,
        //                       // expands: true,
        //                       decoration: InputDecoration(
        //                           // contentPadding: EdgeInsets.only(top: 20),
        //                           hintText: "Title",
        //                           hintStyle:
        //                               Theme.of(context).textTheme.subhead,
        //                           border: InputBorder.none),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             dropdownValue == 'Topic' || dropdownValue == 'Resource'
        //                 ? Expanded(
        //                     // height: MediaQuery.of(context).size.height * 0.3,
        //                     child: TextField(
        //                     keyboardType: TextInputType.multiline,
        //                     onChanged: (value) => setState(() {
        //                       description = value;
        //                     }),
        //                     maxLines: null,
        //                     // expands: true,
        //                     decoration: InputDecoration(
        //                         // contentPadding: EdgeInsets.only(top: 20),
        //                         hintText: "Description",
        //                         hintStyle: Theme.of(context).textTheme.subhead,
        //                         border: InputBorder.none),
        //                   ))
        //                 : Expanded(child: Container()),
        //             dropdownValue == 'Resource' &&
        //                     _paths != null &&
        //                     _paths.isNotEmpty
        //                 ? Container(child: Text('Resources'))
        //                 : Container(),
        //             dropdownValue == 'Resource' &&
        //                     _paths != null &&
        //                     _paths.isNotEmpty
        //                 ? Container(
        //                     height: 75.00 * (_paths.length + 1),
        //                     child: ListView.separated(
        //                       physics: const NeverScrollableScrollPhysics(),
        //                       shrinkWrap: false,
        //                       itemCount: _paths != null && _paths.isNotEmpty
        //                           ? _paths.length
        //                           : 1,
        //                       itemBuilder: (BuildContext context, int index) {
        //                         final bool isMultiPath =
        //                             _paths != null && _paths.isNotEmpty;
        //                         final String name = 'File $index: ' +
        //                             (isMultiPath
        //                                 ? _paths.keys.toList()[index]
        //                                 : _fileName ?? '...');
        //                         final path = isMultiPath
        //                             ? _paths.values.toList()[index].toString()
        //                             : _path;

        //                         return new ListTile(
        //                           title: new Text(
        //                             name,
        //                           ),
        //                           subtitle: new Text(path),
        //                         );
        //                       },
        //                       separatorBuilder:
        //                           (BuildContext context, int index) =>
        //                               new Divider(),
        //                     ),
        //                   )
        //                 : Container(),
        //             dropdownValue == 'Resource'
        //                 ? Row(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: <Widget>[
        //                         SizedBox(
        //                             width: MediaQuery.of(context).size.width *
        //                                 0.43,
        //                             child: FlatButton(
        //                               padding: const EdgeInsets.symmetric(
        //                                   vertical: 12, horizontal: 0),
        //                               onPressed: () => _openFileExplorer(),
        //                               child: new Text("Select Resources"),
        //                               color: Theme.of(context).focusColor,
        //                               textColor: Colors.white,
        //                               shape: const StadiumBorder(),
        //                             )),
        //                         SizedBox(width: 10.0),
        //                         _categories != null
        //                             ? SizedBox(
        //                                 width:
        //                                     MediaQuery.of(context).size.width *
        //                                         0.43,
        //                                 child: Container(
        //                                     decoration: BoxDecoration(
        //                                         color: Theme.of(context)
        //                                             .focusColor,
        //                                         borderRadius:
        //                                             BorderRadius.circular(20)),
        //                                     padding: EdgeInsets.symmetric(
        //                                         vertical: 0, horizontal: 10),
        //                                     child: DropdownButton<String>(
        //                                       value: _selectedCategory,
        //                                       dropdownColor:
        //                                           Theme.of(context).accentColor,
        //                                       iconEnabledColor: Colors.white,
        //                                       style: TextStyle(
        //                                           color: Colors.white),
        //                                       underline: Container(),
        //                                       items: _categories
        //                                           .map((Category category) {
        //                                         return new DropdownMenuItem<
        //                                             String>(
        //                                           value: category.id.toString(),
        //                                           child:
        //                                               new Text(category.name),
        //                                         );
        //                                       }).toList(),
        //                                       onChanged: (String newValue) {
        //                                         setState(() {
        //                                           _selectedCategory = newValue;
        //                                         });
        //                                       },
        //                                     )))
        //                             : Container(),
        //                       ])
        //                 : Container(),
        //             Positioned(
        //               bottom: MediaQuery.of(context).viewInsets.bottom + 40,
        //               left: 0,
        //               right: 0,
        //               child: Container(
        //                 margin: EdgeInsets.all(10.0),
        //                 child: _isLoading
        //                     ? const Center(child: CircularProgressIndicator())
        //                     : SizedBox(
        //                         width: double.infinity,
        //                         child: FlatButton(
        //                           padding: const EdgeInsets.symmetric(
        //                               vertical: 12, horizontal: 0),
        //                           onPressed: () {
        //                             post(context);
        //                           },
        //                           child: Text('Send'),
        //                           color: Theme.of(context).accentColor,
        //                           textColor: Colors.white,
        //                           shape: const StadiumBorder(),
        //                         )),
        //               ),
        //             ),
        //           ],
        //         )))),
        // )
        );
  }
}
