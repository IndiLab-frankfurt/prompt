import 'package:flutter/material.dart';
import 'package:prompt/shared/enums.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void clearHistory() {}

  void pop() {
    return _navigatorKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(AppScreen routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushNamed(routeName.name, arguments: arguments);
  }

  Future<dynamic> navigateWithReplacement(AppScreen routeName,
      {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushReplacementNamed(routeName.name, arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(AppScreen routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName.name, (r) => false,
        arguments: arguments);
  }
}
