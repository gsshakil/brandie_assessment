import 'package:brandie_assessment/apps/core/landing_screen.dart';
import 'package:brandie_assessment/apps/core/splash_screen.dart';
import 'package:brandie_assessment/apps/product/product_details_screen.dart';
import 'package:brandie_assessment/general/constants/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //****************Core App Route***********************
      case RouteConstants.landingRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteConstants.productDetailsRoute:
        var args = settings.arguments as ProductDetailsScreen;
        return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            product: args.product,
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}
