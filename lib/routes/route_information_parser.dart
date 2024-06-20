import 'package:declarative_navigation/model/page_configuration.dart';
import 'package:flutter/widgets.dart';

class MyRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.uri.toString());

    if (uri.pathSegments.isEmpty) {
      return PageConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == 'home') {
        return PageConfiguration.home();
      } else if (first == 'login') {
        return PageConfiguration.login();
      } else if (first == 'register') {
        return PageConfiguration.register();
      } else if (first == 'splash') {
        return PageConfiguration.splash();
      } else {
        return PageConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      final quoteId = int.tryParse(second) ?? 0;
      if (first == 'quote' && (quoteId >= 1 && quoteId <= 5)) {
        return PageConfiguration.detailQuote(second);
      } else {
        return PageConfiguration.unknown();
      }
    } else {
      return PageConfiguration.unknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    if (configuration.isUnknownPage) {
      return RouteInformation(uri: Uri.parse('/unknown'));
    } else if (configuration.isSplashPage) {
      return  RouteInformation(uri: Uri.parse('/splash'));
    } else if (configuration.isRegisterPage) {
      return  RouteInformation(uri: Uri.parse('/register'));
    } else if (configuration.isLoginPage) {
      return  RouteInformation(uri: Uri.parse('/login'));
    } else if (configuration.isHomePage) {
      return  RouteInformation(uri: Uri.parse('/'));
    } else if (configuration.isDetailPage) {
      return RouteInformation(uri: Uri.parse('/quote/${configuration.quoteId}'));
    } else {
      return null;
    }
  }
}
