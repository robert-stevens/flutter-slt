import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stripe_payment/stripe_payment.dart';

import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/membership_options.dart';

class CheckoutScreen extends StatefulWidget {
  MembershipOption membershipOption;

  // In the constructor, require a Todo.
  CheckoutScreen({Key key, @required this.membershipOption}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _showPassword = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  ScrollController _controller = ScrollController();

  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret =
      "sk_test_F6mhEuJF96sCGnfGpwzVQjim00o5LfaPVX"; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent = new PaymentIntentResult();
  Source _source;

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_m1ZYLaDJxMWPVHF0gnTi9Vav002z2SupFM",
        merchantId: "merchant.sharelearnteach",
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        controller: _controller,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              widget.membershipOption.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.membershipOption.subTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('Account Information',
                          style: Theme.of(context).textTheme.display2),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          hintText: 'Username',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.user_1,
                            color:
                                Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color:
                                Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.text,
                        obscureText: !_showPassword,
                        decoration: new InputDecoration(
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.padlock_1,
                            color:
                                Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            color:
                                Theme.of(context).focusColor.withOpacity(0.4),
                            icon: Icon(_showPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.text,
                        obscureText: !_showPassword,
                        decoration: new InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.padlock_1,
                            color:
                                Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            color:
                                Theme.of(context).focusColor.withOpacity(0.4),
                            icon: Icon(_showPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Text("We don't save your card details."),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                        onPressed: () {
                          StripePayment.paymentRequestWithCardForm(
                                  CardFormPaymentRequest())
                              .then((paymentMethod) async {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Received ${paymentMethod.id}')));

                            setState(() {
                              _paymentMethod = paymentMethod;
                            });

                            var mapData = Map();
                            mapData["amount"] = 1099;
                            mapData["currency"] = "aud";
                            mapData["payment_method_types[]"] = "card";
                            String encodedBody = mapData.keys
                                .map((key) => "$key=${mapData[key]}")
                                .join("&");

                            // 4000002760003184

                            final http.Response response = await http.post(
                                "https://api.stripe.com/v1/payment_intents",
                                body: encodedBody,
                                headers: {
                                  "Accept": "application/json",
                                  'Content-Type':
                                      'application/x-www-form-urlencoded',
                                  'Authorization':
                                      'Bearer sk_test_F6mhEuJF96sCGnfGpwzVQjim00o5LfaPVX'
                                });

                            final paymentIntentData =
                                json.decode(response.body);
                            // print('paymentIntentData: $paymentIntentData');
                            // print('_paymentIntent: $_paymentIntent');
                            this.setState(() {
                              _paymentIntent.status =
                                  paymentIntentData["status"];
                              _paymentIntent.paymentIntentId =
                                  paymentIntentData["id"];
                              _paymentIntent.paymentMethodId =
                                  _paymentMethod.id;
                            });
                          }).catchError(setError);
                        },
                        child: Text(
                          'Add Card',
                          style: Theme.of(context).textTheme.title.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                      ),
                      SizedBox(height: 40),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                        onPressed: _paymentMethod == null ||
                                _currentSecret == null
                            ? null
                            : () {
                                if (Theme.of(context).platform ==
                                    TargetPlatform.iOS) {
                                  _controller.jumpTo(450);
                                }
                                StripePayment.paymentRequestWithNativePay(
                                  androidPayOptions: AndroidPayPaymentRequest(
                                    totalPrice:
                                        '${widget.membershipOption.price}',
                                    currencyCode: "GBP",
                                  ),
                                  applePayOptions: ApplePayPaymentOptions(
                                    countryCode: 'GB',
                                    currencyCode: 'GBP',
                                    items: [
                                      ApplePayItem(
                                        label: widget.membershipOption.title,
                                        amount:
                                            '${widget.membershipOption.price}',
                                      )
                                    ],
                                  ),
                                ).then((token) {
                                  setState(() {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Received ${token.tokenId}')));
                                    _paymentToken = token;
                                  });
                                }).catchError(setError);
                              },
                        child: Text(
                          'Checkout Apple Pay',
                          style: Theme.of(context).textTheme.title.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                      ),
                      Divider(),
                      Text('Current source:'),
                      Text(
                        JsonEncoder.withIndent('  ')
                            .convert(_source?.toJson() ?? {}),
                        style: TextStyle(fontFamily: "Monospace"),
                      ),
                      Divider(),
                      Text('Current token:'),
                      Text(
                        JsonEncoder.withIndent('  ')
                            .convert(_paymentToken?.toJson() ?? {}),
                        style: TextStyle(fontFamily: "Monospace"),
                      ),
                      Divider(),
                      Text('Current payment method:'),
                      Text(
                        JsonEncoder.withIndent('  ')
                            .convert(_paymentMethod?.toJson() ?? {}),
                        style: TextStyle(fontFamily: "Monospace"),
                      ),
                      Divider(),
                      Text('Current payment intent:'),
                      Text(
                        JsonEncoder.withIndent('  ')
                            .convert(_paymentIntent?.toJson() ?? {}),
                        style: TextStyle(fontFamily: "Monospace"),
                      ),
                      Divider(),
                      Text('Current error: $_error'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
