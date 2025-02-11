import 'package:get/get.dart';

import '../Controller/RoutingController.dart';


class RoutingMiddleware extends GetMiddleware {
  RoutingController routingController = Get.put(RoutingController());

  @override
  GetPage? onPageCalled(GetPage? page) {
    print("Get page current route: ${page?.name}");
    routingController.currentRoute.value = page!.name;
    routingController.changeRoute(page.name);
    return super.onPageCalled(page);
  }

  @override
  void onPageDispose() {
    print("Get page previous route: ${Get.previousRoute}");
    print("Page disposed. New current route: ${routingController.currentRoute.value}");
    super.onPageDispose();
  }

}
