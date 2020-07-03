import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shareLearnTeach/src/models/membership_options.dart';
import 'package:shareLearnTeach/src/screens/checkout.dart';
// import 'package:shareLearnTeach/src/widgets/MembershipItem.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  int _current = 0;
  MembershipOptionList _membershipOptionList;
  @override
  void initState() {
    _membershipOptionList = new MembershipOptionList();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(UiIcons.return_icon, color: Theme.of(context).accentColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Image.asset('img/membership.png'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            Text(
              'Membership Options',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: CarouselSlider(
                height: 550.0,
                viewportFraction: 1.0,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
                items: _membershipOptionList.list
                    .map((MembershipOption membershipOption) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 4.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 8.0),
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      membershipOption.title,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 24,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      membershipOption.subTitle,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          membershipOption.benefits.length,
                                      itemExtent: 30,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          dense: true,
                                          leading: Icon(Icons.check),
                                          title: Text(
                                            membershipOption.benefits
                                                .elementAt(index),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead,
                                          ),
                                        );
                                      }),
                                  // Spacer(
                                  //   flex: 8,
                                  // ),
                                  Spacer(),
                                  Text('Pay by Credit Card / Debit Card '),
                                  Container(
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 70),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute<void>(builder:
                                                (BuildContext context) {
                                          return CheckoutScreen(
                                              membershipOption:
                                                  membershipOption);
                                        }));
                                      },
                                      child: Text(
                                        'Choose Option',
                                        style: Theme.of(context)
                                            .textTheme
                                            .title
                                            .merge(
                                              TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                      ),
                                      color: Theme.of(context).accentColor,
                                      shape: const StadiumBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: _membershipOptionList.list
                          .map((MembershipOption membershipOption) {
                        return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              color: _current ==
                                      _membershipOptionList.list
                                          .indexOf(membershipOption)
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.8)
                                  : Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2)),
                        );
                      }).toList(),
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
