import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:stripe_payment/stripe_payment.dart';

import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:shareLearnTeach/src/models/membership_options.dart';
import 'package:shareLearnTeach/src/models/user.dart';

class CheckoutScreen extends StatefulWidget {
  MembershipOption membershipOption;

  // In the constructor, require a Todo.
  CheckoutScreen({Key key, @required this.membershipOption}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _showPassword = false;
  bool _isLoading = false;

  final FocusScopeNode _node = FocusScopeNode();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  ScrollController _controller = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final User _user = User();

  final String assetName = 'assets/up_arrow.svg';
  final Widget svgIcon = SvgPicture.asset(
    'img/apple.svg',
    color: Colors.white,
    semanticsLabel: 'Apple Logo',
    width: 17,
    height: 17,
  );

  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _name;
  String _surname;
  String _email;
  String _password;
  String _confirmPassword;
  String _error;
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
        publishableKey: "pk_live_Pi8VXB6vWB4Uv2IYZKvyD4Ox00o3pmYFci",
        merchantId: "merchant.sharelearnteach",
        androidPayMode: 'test'));

    createPaymentIntent();
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  void createPaymentIntent() async {
    var amount = widget.membershipOption.price * 100;
    var response = await _user.getPaymentIntent(amount.toInt());
    // print('paymentIntentId: ${response.id}');
    this.setState(() {
      _paymentIntent.status = response['status'];
      _paymentIntent.paymentIntentId = response['id'];
    });
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  void _handleRegister(BuildContext content) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      setState(() {
        _isLoading = true;
      });

      final dynamic response = await _user.register(
          _name,
          _surname,
          _email,
          _password,
          widget.membershipOption.level,
          widget.membershipOption.price,
          _paymentIntent.paymentIntentId);
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed('/Tabs', arguments: 0);
      } else {
        final dynamic error = json.decode(response.body as String);

        setState(() {
          _isLoading = false;
          _error = error['error_description'] as String;
        });
      }
    } else {
      // handle form errors
    }
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
                  child: Form(
                      key: _formKey,
                      child: FocusScope(
                          node: _node,
                          child: Column(
                            children: <Widget>[
                              Text('Account Information',
                                  style: Theme.of(context).textTheme.display2),
                              SizedBox(height: 20),
                              new TextFormField(
                                onEditingComplete: _node.nextFocus,
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val.isEmpty) return "Name can't be empty";
                                  return null;
                                },
                                onChanged: (String value) {
                                  _name = value;
                                },
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  hintText: 'Name',
                                  hintStyle:
                                      Theme.of(context).textTheme.body1.merge(
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
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              new TextFormField(
                                onEditingComplete: _node.nextFocus,
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val.isEmpty)
                                    return "Surname can't be empty";
                                  return null;
                                },
                                onChanged: (String value) {
                                  _surname = value;
                                },
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  hintText: 'Surname',
                                  hintStyle:
                                      Theme.of(context).textTheme.body1.merge(
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
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              new TextFormField(
                                onEditingComplete: _node.nextFocus,
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val.isEmpty)
                                    return "Email address can't be empty";
                                  if (!RegExp(
                                          "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(val))
                                    return "Email address must be valid";
                                  return null;
                                },
                                onChanged: (String value) {
                                  _email = value;
                                },
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
                                  hintText: 'Email Address',
                                  hintStyle:
                                      Theme.of(context).textTheme.body1.merge(
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
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              new TextFormField(
                                onEditingComplete: _node.nextFocus,
                                textInputAction: TextInputAction.next,
                                controller: _pass,
                                validator: (val) {
                                  if (val.isEmpty)
                                    return "Password can't be empty";
                                  return null;
                                },
                                onChanged: (String value) {
                                  _password = value;
                                },
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                                keyboardType: TextInputType.text,
                                obscureText: !_showPassword,
                                decoration: new InputDecoration(
                                  hintText: 'Password',
                                  hintStyle:
                                      Theme.of(context).textTheme.body1.merge(
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
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
                                    icon: Icon(_showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              new TextFormField(
                                textInputAction: TextInputAction.done,
                                validator: (val) {
                                  if (val.isEmpty) return 'Empty';
                                  if (val != _pass.text)
                                    return "Passwords don't match";
                                  return null;
                                },
                                onChanged: (String value) {
                                  _confirmPassword = value;
                                },
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                                keyboardType: TextInputType.text,
                                obscureText: !_showPassword,
                                decoration: new InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle:
                                      Theme.of(context).textTheme.body1.merge(
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
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
                                    icon: Icon(_showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : FlatButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 70),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          if (Theme.of(context).platform ==
                                              TargetPlatform.iOS) {
                                            _controller.jumpTo(450);
                                          }
                                          StripePayment
                                              .paymentRequestWithNativePay(
                                            androidPayOptions:
                                                AndroidPayPaymentRequest(
                                              totalPrice:
                                                  '${widget.membershipOption.price}',
                                              currencyCode: "GBP",
                                            ),
                                            applePayOptions:
                                                ApplePayPaymentOptions(
                                              countryCode: 'GB',
                                              currencyCode: 'GBP',
                                              items: [
                                                ApplePayItem(
                                                  label: widget
                                                      .membershipOption.title,
                                                  amount:
                                                      '${widget.membershipOption.price}',
                                                )
                                              ],
                                            ),
                                          ).then((token) async {
                                            await StripePayment
                                                .completeNativePayRequest();
                                            setState(() {
                                              _scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Payment successful. Creating membership account.')));
                                              _paymentToken = token;
                                            });
                                            _handleRegister(context);
                                          }).catchError(setError);
                                        }
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Subscribe with ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .merge(
                                                  TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                          ),
                                          svgIcon,
                                          Text(
                                            ' Pay',
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .merge(
                                                  TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                          ),
                                        ],
                                      ),
                                      color: Colors.black,
                                    ),
                              const SizedBox(height: 20),
                              _error != null && _error.isNotEmpty
                                  ? Text(
                                      _error,
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Text(''),
                              // Divider(),
                              // Text('Current source:'),
                              // Text(
                              //   JsonEncoder.withIndent('  ')
                              //       .convert(_source?.toJson() ?? {}),
                              //   style: TextStyle(fontFamily: "Monospace"),
                              // ),
                              // Divider(),
                              // Text('Current token:'),
                              // Text(
                              //   JsonEncoder.withIndent('  ')
                              //       .convert(_paymentToken?.toJson() ?? {}),
                              //   style: TextStyle(fontFamily: "Monospace"),
                              // ),
                              // Divider(),
                              // Text('Current payment method:'),
                              // Text(
                              //   JsonEncoder.withIndent('  ')
                              //       .convert(_paymentMethod?.toJson() ?? {}),
                              //   style: TextStyle(fontFamily: "Monospace"),
                              // ),
                              // Divider(),
                              // Text('Current payment intent:'),
                              // Text(
                              //   JsonEncoder.withIndent('  ')
                              //       .convert(_paymentIntent?.toJson() ?? {}),
                              //   style: TextStyle(fontFamily: "Monospace"),
                              // ),
                              // Divider(),
                              // Text('Current error: $_error'),
                            ],
                          ))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
