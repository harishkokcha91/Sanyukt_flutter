import 'package:get/get.dart';

class RoutingController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxString currentRoute = "/".obs;


  @override
  void onInit() {
    super.onInit();
  }
  changeRoute(String newRoute) async{
    currentRoute.value = newRoute;
  }


}
