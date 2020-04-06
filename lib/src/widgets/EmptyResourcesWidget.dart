import 'package:shareLearnTeach/config/app_config.dart' as config;
import 'package:shareLearnTeach/config/ui_icons.dart';
import 'package:flutter/material.dart';

class EmptyResourcesWidget extends StatelessWidget {
  const EmptyResourcesWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: config.App(context).appHeight(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                      Theme.of(context).focusColor,
                      Theme.of(context).focusColor.withOpacity(0.1),
                    ])),
                child: Icon(
                  UiIcons.file,
                  color: Theme.of(context).primaryColor,
                  size: 70,
                ),
              ),
              Positioned(
                right: -30,
                bottom: -50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                top: -50,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Opacity(
            opacity: 0.4,
            child: Text(
              'No resources find, try again.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display2.merge(TextStyle(fontWeight: FontWeight.w300)),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
