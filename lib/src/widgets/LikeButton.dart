import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonMainState extends State {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      onTap: (bool isLiked) {
        return _like(isLiked);
      },
      circleColor:
          CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: _isLiked ? Color(0xFFDF5757) : Colors.grey,
        );
      },
    );
  }

  Future _like(isLiked) async {
    isLiked = !isLiked;
    return isLiked;
  }
}
