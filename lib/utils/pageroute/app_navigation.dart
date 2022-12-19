
import 'package:cryptotest/models/conversion_arg.dart';
import 'package:cryptotest/ui/pages/conversion_page.dart';
import 'package:cryptotest/ui/pages/homepage.dart';

import 'package:flutter/material.dart';


class AppNavigation {
  AppNavigation._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case RouteNames.HomePage:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const HomePage(),
        );
      case RouteNames.conversionPage:
        final args = settings.arguments as ConversionPageArguements;

        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: ConvertToNairaPage(
              coinList: args.coinList, selectedCoin: args.selectedCoin),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static PageRoute _getPageRoute(
      {required String routeName, required Widget viewToShow}) {
    return MaterialPageRoute(
        settings: RouteSettings(
          name: routeName,
        ),
        builder: (_) => viewToShow);
  }
}



class RouteNames {
  RouteNames._();

// Views constant
  static const String HomePage = '/crypto-list-page';
  static const String conversionPage = '/conversion-page';
}
