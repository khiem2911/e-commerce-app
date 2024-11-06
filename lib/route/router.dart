import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/route/screen_export.dart';
import 'package:ecommerce_app/screens/login/login.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(
        builder: (context) => const Home(),
      );
    case recoveryRoute:
      return MaterialPageRoute(builder: (context) => const PasswordRecovery());
    case locationRoute:
      return MaterialPageRoute(builder: (context) => const Location());
    case searchLocationRoute:
      return MaterialPageRoute(builder: (context) => const SearchLocation());
    case searchItemRoute:
      return MaterialPageRoute(builder: (context) => const Search());
    case searchResultItemRoute:
      return MaterialPageRoute(
          builder: (context) => SeachResult(
                title: settings.arguments as String,
              ));
    case tabsBottomRoute:
      return MaterialPageRoute(builder: (context) => const Tabs());
    case detailRoute:
      return MaterialPageRoute(
          builder: (context) => Detail(item: settings.arguments as Item));
    case categoriesRoute:
      return MaterialPageRoute(
          builder: (context) =>
              Categories(title: settings.arguments as String));
    case checkOutRoute:
      return MaterialPageRoute(builder: (context) => const Checkout());
    case loginRoute:
      return MaterialPageRoute(builder: (context) => const Login());
    case orderRoute:
      return MaterialPageRoute(builder: (context) => const Order());
    case profileRoute:
      return MaterialPageRoute(builder: (context) => const Profile());
    default:
      return MaterialPageRoute(builder: (context) => const Splash());
  }
}
