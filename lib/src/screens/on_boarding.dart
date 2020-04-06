import 'package:carousel_slider/carousel_slider.dart';
import 'package:shareLearnTeach/src/models/on_boarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingWidget extends StatefulWidget {
  @override
  _OnBoardingWidgetState createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  int _current = 0;
  OnBoardingList _onBoardingList;
  @override
  void initState() {
    _onBoardingList = new OnBoardingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.96),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: CarouselSlider(
                height: 500.0,
                viewportFraction: 1.0,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
                items: _onBoardingList.list.map((OnBoarding boarding) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.asset(
                              boarding.image,
                              width: 480,
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                boarding.description,
                                style: Theme.of(context).textTheme.display1,textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: _onBoardingList.list.map((OnBoarding boarding) {
                        return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              color: _current == _onBoardingList.list.indexOf(boarding)
                                  ? Theme.of(context).hintColor.withOpacity(0.8)
                                  : Theme.of(context).hintColor.withOpacity(0.2)),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/SignIn');
                      },
                      child:Text(
                            'Skip',
                            style: Theme.of(context).textTheme.display1.merge(
                                  TextStyle(color: Theme.of(context).primaryColor),
                                ),
                      ),
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            )     
          ],
        ),
      ),
    );
  }
}
