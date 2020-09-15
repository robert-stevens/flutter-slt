import 'package:flutter/material.dart';
import 'package:shareLearnTeach/src/models/route_argument.dart';
// import 'package:shareLearnTeach/src/models/topic.dart';
import 'package:shareLearnTeach/src/screens/Categorie.dart';
import 'package:shareLearnTeach/src/screens/account.dart';
import 'package:shareLearnTeach/src/screens/post.dart';
import 'package:shareLearnTeach/src/screens/Categories.dart';
// import 'package:shareLearnTeach/src/screens/tabs/Resources.dart';
// import 'package:shareLearnTeach/src/screens/forums/index.dart';
// import 'package:shareLearnTeach/src/screens/forums/topic.dart';
// import 'package:shareLearnTeach/src/screens/forums/job_bulletin.dart';
// import 'package:shareLearnTeach/src/screens/favorites.dart';
import 'package:shareLearnTeach/src/screens/languages.dart';
// import 'package:shareLearnTeach/src/screens/on_boarding.dart';
import 'package:shareLearnTeach/src/screens/signin.dart';
import 'package:shareLearnTeach/src/screens/signup.dart';
// import 'package:shareLearnTeach/src/screens/splashScreen.dart';
import 'package:shareLearnTeach/src/screens/tabs.dart';
import 'package:shareLearnTeach/src/screens/utilitie.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute<dynamic>(
            builder: (_) => TabsWidget(currentTab: 0, categoryList: null));
      case '/SignIn':
        return MaterialPageRoute<dynamic>(builder: (_) => SignInWidget());
      case '/SignUp':
        // return webview widget
        return MaterialPageRoute<dynamic>(builder: (_) => SignUpWidget());
      case '/Account':
        return MaterialPageRoute<dynamic>(builder: (_) => AccountWidget());
      case '/Post':
        return MaterialPageRoute<dynamic>(
            builder: (_) => PostWidget(postType: 'Status'));
      case '/Tabs':
        return MaterialPageRoute<dynamic>(
            builder: (_) => TabsWidget(
                  currentTab: args as int,
                ));
      case '/Utilities':
        return MaterialPageRoute<dynamic>(
            builder: (_) => UtilitieWidget(
                  routeArgument: args as RouteArgument,
                ));
      case '/Languages':
        return MaterialPageRoute<dynamic>(builder: (_) => LanguagesWidget());
      case '/Categories':
        return MaterialPageRoute<dynamic>(builder: (_) => CategoriesWidget());
      // case '/Favourites':
      //   return MaterialPageRoute(builder: (_) => FavoritesWidget());
      // case '/Resources':
      //   return MaterialPageRoute<dynamic>(builder: (_) => ResourcesWidget());
      // case '/Forums':
      //   return MaterialPageRoute<dynamic>(builder: (_) => ForumsScreen());
      // case '/Topic':
      //   return MaterialPageRoute<dynamic>(builder: (_) => TopicScreen());
      // case '/Jobs':
      //   return MaterialPageRoute<dynamic>(builder: (_) => const JobBulletinScreen());
      case '/Categorie':
        return MaterialPageRoute<dynamic>(
            builder: (_) => CategorieWidget(
                  routeArgument: args as RouteArgument,
                ));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
