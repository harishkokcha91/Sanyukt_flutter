import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Routing/Controller/RoutingController.dart';

class CustomNavigator {

  static final CustomNavigator _instance = CustomNavigator._internal();

  factory CustomNavigator() {
    return _instance;
  }

  CustomNavigator._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static String _currentRoute = '/';

  static String get currentRoute => _currentRoute;

  static set currentRoute(String val){
    _currentRoute = val;
  }


  // Pushes to the route specified
  static Future<dynamic> pushTo(String strPageName, {var arguments}) async {
    _currentRoute = strPageName;
    Get.put(RoutingController()).currentRoute.value = strPageName;
    print("Updated current route in bottom nav mob 2 ${_currentRoute}");
    return await Get.toNamed(strPageName, arguments: arguments);
  }

  static Future<dynamic> pushToParams(String strPageName, {var parameters}) async {
    _currentRoute = strPageName;
    Get.put(RoutingController()).currentRoute.value = strPageName;
    return await Get.toNamed(strPageName, parameters: parameters);
  }

  // Pop the top view
  static Future<dynamic> pop({var result}) async {
    Get.back(result: result);
    Get.put(RoutingController()).changeRoute(Get.previousRoute);
  }

  // Pops to a particular view
  static Future<dynamic> popTo(String strPageName, {var result})async {
    _currentRoute = strPageName;
    Get.put(RoutingController()).currentRoute.value = strPageName;

    return await Get.offNamedUntil(strPageName, (route) => false, parameters: result);
  }

  static Future<dynamic> pushOff(String strPageName, {var arguments})async {
    _currentRoute = strPageName;
    Get.put(RoutingController()).currentRoute.value = strPageName;
    print("Updated current route in bottom nav mob 3 ${_currentRoute}");
    return await Get.offNamed(strPageName, arguments: arguments);
  }

  static Future<dynamic> pushReplace(String strPageName, {var arguments}) async{
    _currentRoute = strPageName;
    Get.put(RoutingController()).currentRoute.value = strPageName;
    return await Get.offAllNamed(strPageName, arguments: arguments);
  }
}
