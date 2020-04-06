import 'package:shareLearnTeach/src/models/review.dart';
import 'package:shareLearnTeach/src/widgets/ReviewItemWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReviewsListWidget extends StatelessWidget {
  final ReviewsList _reviewsList = ReviewsList();

  ReviewsListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        return ReviewItemWidget(review: _reviewsList.reviewsList.elementAt(index));
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 30,
        );
      },
      itemCount: _reviewsList.reviewsList.length,
      primary: false,
      shrinkWrap: true,
    );
  }
}
