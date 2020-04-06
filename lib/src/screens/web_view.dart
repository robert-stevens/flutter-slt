import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWebPage extends StatelessWidget {
  const WebViewWebPage({this.title,this.url});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: WebView(
      initialUrl: url,
      )
    );
  }
}