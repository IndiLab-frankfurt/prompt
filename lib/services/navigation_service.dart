import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void clearHistory() {}

  void pop() {
    return _navigatorKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateWithReplacement(String routeName,
      {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName, {dynamic arguments}) {
    return _navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (r) => false, arguments: arguments);
  }
}
