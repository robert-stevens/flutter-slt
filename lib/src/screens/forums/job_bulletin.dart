// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import 'package:shareLearnTeach/src/widgets/DrawerWidget.dart';
// import 'package:shareLearnTeach/src/models/reply.dart';
// import 'package:shareLearnTeach/src/models/user.dart';
// import 'package:shareLearnTeach/src/models/category.dart';
// import 'package:shareLearnTeach/src/widgets/FilterWidget.dart';
// import 'package:shareLearnTeach/src/widgets/CardForumItem.dart';
// import 'package:shareLearnTeach/src/widgets/EmptyResourcesWidget.dart';

// class JobBulletinScreen extends StatefulWidget {

//   const JobBulletinScreen({Key key, this.categoryList});

//   final List<Category> categoryList;

//   @override
//   _JobBulletinScreenState createState() => _JobBulletinScreenState();
// }

// class _JobBulletinScreenState extends State<JobBulletinScreen> {

//   _JobBulletinScreenState() {
//     User().getUser().then((User val) => setState(() {
//       _profilePicture = val.avatar;
//     }));
//   }

//   @override
//   void initState() {
//     super.initState();
//     _topic = Reply.getJobBulletinTopic();
//     _getTopicReplies('12985'); 
//   }

//   Future<void> _getTopicReplies(String parentId) async {

//     if(_parentId != parentId){
//       setState(() {
//         _replies = <Reply>[];
//         _parentId = parentId;
//       });
//     }
//     final List<Reply> newItems = await Reply.getReplies(_parentId, _replies.length, incrementCount);

//     if (_replies == null || _replies.isEmpty){
//       _replies = newItems;
//     } else {
//       _replies.addAll( newItems);
//     }

//     setState(() => {
//       _replies = _replies,
//       _isLoading = false
//     });
//   }

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   Reply _topic;
//   List<Reply> _replies = <Reply>[]; 
//   String layout = 'list';
//   bool _isLoading = true;

//   String _profilePicture;
//   String _parentId = '';
//   int incrementCount = 10;

//   ListView _buildItemsForListView(BuildContext context, int index) {
//       return ListView.separated(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       itemBuilder: (BuildContext context, int index) {
//         // print('CardForumItem index: $index');
//         // return CardForumItem(reply: _replies.elementAt(index), );
//       },
//       separatorBuilder: (BuildContext context, int index) {
//         return const Divider(
//           height: 30,
//         );
//       },
//       itemCount: _replies.length,
//       primary: false,
//       shrinkWrap: true,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print('list length: ${_replies.length}');
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: DrawerWidget(),
//       endDrawer: FilterWidget(),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
//           onPressed: () => _scaffoldKey.currentState.openDrawer(),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           'Job Bulletin',
//           style: Theme.of(context).textTheme.display1,
//         ),
//         actions: <Widget>[
//           Container(
//               width: 30,
//               height: 30,
//               margin: const EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(300),
//                 onTap: () {
//                   Navigator.of(context).pushNamed('/Account');
//                 },
//                 child: CircleAvatar(
//                   backgroundImage: NetworkImage(_profilePicture),
//                 )
//               )),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           const SizedBox(height: 20),
//           // TOPIC
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColor.withOpacity(0.9),
//               boxShadow: [
//                 BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
//               ],
//             ),
//             // child: CardForumItem(reply: _topic),
//           ),
//           const SizedBox(height: 20),
//           // REPLIES
//           !_isLoading && _replies.isEmpty ? EmptyResourcesWidget() : SizedBox(height: 1),
//           Expanded(
//             child:  _isLoading && _replies.isEmpty ? const Center(
//                 child: CircularProgressIndicator(),
//               ) : _buildItemsForListView(context, _replies.length)
//           ),
//           // Flexible(child:
//           //   _isLoading ? 
//           //     const Center(child: CircularProgressIndicator()) 
//           //   :
//           //   _buildItemsForListView(context, _replies.length)),
//           const SizedBox(height: 20),
//         ],
//       ),
  
//     );
//   }
// }
