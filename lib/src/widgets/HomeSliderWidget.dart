import 'package:carousel_slider/carousel_slider.dart';
import 'package:listing/src/models/slider.dart';
import 'package:listing/src/models/slider.dart' as prefix0;
import 'package:flutter/material.dart';

class HomeSliderWidget extends StatefulWidget {
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;
  SliderList _sliderList = new SliderList();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        CarouselSlider(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          height: 200,
          viewportFraction: 1.0,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
          items: _sliderList.list.map((prefix0.Slider slide) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(slide.image), fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 4), blurRadius: 9)
                    ],
                  ),
                  child: Container(
                    alignment: AlignmentDirectional.bottomEnd,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _sliderList.list.map((prefix0.Slider slide) {
              return Container(
                width: 20.0,
                height: 3.0,
                margin: EdgeInsets.symmetric(vertical: 70.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: _current == _sliderList.list.indexOf(slide)
                        ? Theme.of(context).hintColor
                        : Theme.of(context).hintColor.withOpacity(0.3)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
