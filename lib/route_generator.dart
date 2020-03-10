import 'package:flutter/material.dart';
import 'package:listing/src/models/route_argument.dart';
import 'package:listing/src/screens/Categorie.dart';
import 'package:listing/src/screens/account.dart';
import 'package:listing/src/screens/Categories.dart';
import 'package:listing/src/screens/Resources.dart';
import 'package:listing/src/screens/favorites.dart';
import 'package:listing/src/screens/languages.dart';
import 'package:listing/src/screens/on_boarding.dart';
import 'package:listing/src/screens/signin.dart';
import 'package:listing/src/screens/signup.dart';
import 'package:listing/src/screens/splashScreen.dart';
import 'package:listing/src/screens/tabs.dart';
import 'package:listing/src/screens/utilitie.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        // return MaterialPageRoute(builder: (_) => Splash());
        return MaterialPageRoute(builder: (_) => SignInWidget());
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignInWidget()); 
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());  
      case '/Account':
        return MaterialPageRoute(builder: (_) => AccountWidget()); 
      case '/Tabs':
        return MaterialPageRoute(builder: (_) => TabsWidget(currentTab: args,));    
      case '/Utilities':
        return MaterialPageRoute(builder: (_) => UtilitieWidget(routeArgument: args as RouteArgument,));
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Categories':
        return MaterialPageRoute(builder: (_) => CategoriesWidget());
      // case '/Favourites':
      //   return MaterialPageRoute(builder: (_) => FavoritesWidget());
      case '/Resources':
        return MaterialPageRoute(builder: (_) => ResourcesWidget());
      case '/Categorie':
        return MaterialPageRoute(builder: (_) => CategorieWidget(routeArgument: args as  RouteArgument,));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
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
