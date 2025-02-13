import 'package:get/get.dart';
import 'package:timesheetgt/Pages/DriverHome.dart';
import 'package:timesheetgt/Pages/DriverTicketListPage.dart';

import '../../Pages/LoginEntryPoint.dart';
import '../../Pages/LogoutWeb.dart';
import '../../Pages/Splash.dart';
import '../Middleware/AuthMiddleware.dart';
import '../Middleware/Middleware.dart';
import 'AppRoutes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final List<GetMiddleware> middleWares = [
    AuthMiddleware(),
    RoutingMiddleware(),
  ];

  static final routes = [
    GetPage(
        name: Routes.SPLASH,
        page: () => const Splash(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.LOGIN,
        page: () => const LoginEntryPoint(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.HOME,
        // middlewares: middleWares,
        page: () => const DriverHome(),
        transition: Transition.noTransition),

    GetPage(
        name: Routes.JOB_LIST,
        // middlewares: middleWares,
        page: () => const DriverTicketListPage(),
        transition: Transition.noTransition),



    GetPage(
        name: Routes.LOGOUT,
        page: () => const LogoutWeb(),
        transition: Transition.noTransition),

  ];
}
