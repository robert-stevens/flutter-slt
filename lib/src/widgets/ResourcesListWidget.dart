// import 'package:shareLearnTeach/src/models/resource.dart';
// import 'package:shareLearnTeach/src/widgets/ResourceItemWidget.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class ResourcesListWidget extends StatelessWidget {
//   // final ResourcesList _resourceList = ResourcesList();

//   ResourcesListWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       itemBuilder: (BuildContext context, int index) {
//         return ResourceItemWidget(resource: _resourceList.resourcesList.elementAt(index));
//       },
//       separatorBuilder: (BuildContext context, int index) {
//         return const Divider(
//           height: 30,
//         );
//       },
//       itemCount: _resourceList.resourcesList.length,
//       primary: false,
//       shrinkWrap: true,
//     );
//   }
// }
