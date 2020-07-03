import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
// https://gist.github.com/putraxor/03ad59c117122b74155a77e5c101ff2a
///TODO: check performance impact bro !!!
class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: new TapGestureRecognizer()
              ..onTap = () => launcher.launch(url));
}

class RichTextView extends StatelessWidget {
  final String text;

  RichTextView({@required this.text});

  bool _isLink(String input) {
    // print(input);
    final matcher = new RegExp(
        r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");
    return matcher.hasMatch(input);
  }

  bool _isUsername(String input){
    final matcher = new RegExp(
        r'^[@]+([@]?[a-zA-Z0-9])*$');
    return matcher.hasMatch(input);
  }

  String _displayLink(String input){
      final urlRegExp = new RegExp(r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
      final urlMatches = urlRegExp.allMatches(text);
      List<String> urls = urlMatches.map(
              (urlMatch) => text.substring(urlMatch.start, urlMatch.end))
          .toList();
      // urls.forEach((x) => print(x));

    for(var url in urls) {
      return url;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context).textTheme.body1;
    final words = text.split(' ');
    List<TextSpan> span = [];
    words.forEach((word) {
      span.add(_isLink(word)
          ? new LinkTextSpan(
              text: '$word ',
              url: _displayLink(word),
              style: _style.copyWith(color: Colors.blue))
          : _isUsername(word) 
            ? new TextSpan(text: '$word ', style: _style.copyWith(color: Colors.blue)) 
            : new TextSpan(text: '$word ', style: _style));
    });
    if (span.length > 0) {
      return new RichText(
        textAlign: TextAlign.left,
        text: new TextSpan(text: '', children: span, style: TextStyle()),
      );
    } else {
      return new Text(text, 
        textAlign: TextAlign.left,
        softWrap: true,
        style: Theme.of(context).textTheme.body1,);
    }
  }
}