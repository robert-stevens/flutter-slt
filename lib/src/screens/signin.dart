import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareLearnTeach/config/ui_icons.dart';
// import 'package:shareLearnTeach/src/widgets/SocialMediaWidget.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:shareLearnTeach/src/screens/web_view.dart';
// import 'package:shareLearnTeach/src/screens/tabs.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _isLoading = false;
  bool _showPassword = false;
  String _email;
  String _password;
  String _error;
  final User user = User();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // SnackBar _snackBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleLogin(BuildContext content) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      setState(() {
        _isLoading = true;
      });

      //for testing
      // _email = 'RobertStevens';
      // _password = 'Rob5@W3bpr355';
      // _email = 'flinders';
      // _password = '5t3V3n@5t';

      final dynamic response = await user.loginUser(_email, _password);
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
        backgroundColor: Theme.of(context).accentColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(UiIcons.return_icon, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 25),
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: const Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Image.asset('img/logo.png'),
                        const SizedBox(height: 25),
                        Text('Sign In',
                            style: Theme.of(context).textTheme.display2),
                        const SizedBox(height: 20),
                        TextField(
                          style: TextStyle(color: Theme.of(context).focusColor),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (String value) {
                            _email = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Username / Email Address',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.6)),
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
                                  Theme.of(context).focusColor.withOpacity(0.6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: TextStyle(color: Theme.of(context).focusColor),
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword,
                          onChanged: (String value) {
                            _password = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.6)),
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
                                  Theme.of(context).focusColor.withOpacity(0.6),
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
                        const SizedBox(height: 20),
                        // FlatButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     'Forgot your password ?',
                        //     style: Theme.of(context).textTheme.body1,
                        //   ),
                        // ),
                        // FlatButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     'Forgot your password ?',
                        //     style: Theme.of(context).textTheme.body1,
                        //   ),
                        // ),
                        _error != null && _error.isNotEmpty
                            ? Text(
                                _error,
                                style: TextStyle(color: Colors.red),
                              )
                            : Text(''),
                        const SizedBox(height: 30),
                        _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : FlatButton(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 70),
                                onPressed: () {
                                  _handleLogin(context);
                                },
                                child: Text(
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .merge(
                                        TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                ),
                                color: Theme.of(context).accentColor,
                                shape: const StadiumBorder(),
                              ),
                        const SizedBox(height: 20),
                        // Text(
                        //   'Or using social media',
                        //   style: Theme.of(context).textTheme.body1,
                        // ),
                        // SizedBox(height: 20),
                        // new SocialMediaWidget()
                      ],
                    ),
                  ),
                ),
              ],
            ),
            FlatButton(
              onPressed: () {
                // Navigator.of(context).pushNamed('/SignUp');

                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return const WebViewWebPage(
                      title: 'Premium Membership Options',
                      url:
                          'https://sharelearnteach.com/membership-account/pe-resources-membership-levels/');
                }));
              },
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: [
                    const TextSpan(text: 'Don\'t have an account ?'),
                    TextSpan(
                        text: ' Sign Up',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
