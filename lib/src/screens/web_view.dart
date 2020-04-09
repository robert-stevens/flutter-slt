import 'package:flutter/material.dart';
import 'package:shareLearnTeach/config/ui_icons.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewWebPage extends StatelessWidget {
  const WebViewWebPage({this.title,this.url});

  final String title;
  final String url;

  final kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
            url: url,
            // javascriptChannels: jsChannels,
            mediaPlaybackRequiresUserGesture: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(UiIcons.return_icon, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Theme.of(context).accentColor,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(title, style: TextStyle(color: Colors.white),),
            ),
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: const Center(
                child: CircularProgressIndicator(),
            ),
    );
  }
}