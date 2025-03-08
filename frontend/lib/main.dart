// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/create_rule_screen.dart';
import 'screens/edit_rule_screen.dart';
import 'models/rule.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rule Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: _AppRouteInformationParser(),
      routerDelegate: _AppRouterDelegate(),
    );
  }
}

class _AppRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) async {
    return routeInformation.location ?? '/';
  }

  @override
  RouteInformation restoreRouteInformation(String configuration) {
    return RouteInformation(location: configuration);
  }
}

class _AppRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String? _route;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  String get currentConfiguration => _route ?? '/';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: [
        MaterialPage(
          child: _buildPage(_route ?? '/'),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        _route = '/';
        notifyListeners();
        return true;
      },
    );
  }

  Widget _buildPage(String route) {
    switch (route) {
      case '/':
        return HomeScreen();
      case '/create':
        return CreateRuleScreen();
      default:
        return Scaffold(
          body: Center(
            child: Text('Page not found'),
          ),
        );
    }
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    _route = configuration;
    notifyListeners();
  }
}