import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Networking/AuthenticationApi.dart';
import '../Routing/Util/AppRoutes.dart';
import '../Utils/CustomNavigator.dart';
import '../Utils/PreferenceManager.dart';

class AuthController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxBool isLogoutLoading = false.obs;
  RxBool isUpdateAvailable = false.obs;
  RxBool isSendingOTP = false.obs;
  RxBool isLoadingCountries = false.obs;
  RxBool showOTPButton = false.obs;
  RxString? gReCaptchaToken = ''.obs;
  RxBool isAccountDeactivate = false.obs;
  RxInt start = 120.obs;
  RxBool allowRetry = false.obs;

  RxString stErrorMsg = ''.obs;
  RxString stOTPErrorMsg = ''.obs;

  RxBool isRedFlagged = false.obs;

  late Timer timer;
  int lastScreenIndex = 0;
  Rxn<TabController> tabController = Rxn<TabController>();
  RxString welcomeError = "".obs;
  @override
  void onInit() {
    super.onInit();
  }
  checkIfLoggedIn() async {
    bool isLogin = await PreferenceManager().getLogin();
    if (isLogin) {
        CustomNavigator.pushReplace(Routes.HOME);
      } else {
        CustomNavigator.pushReplace(Routes.LOGIN);
      }
  }

  logOut() async {
    await callLogout();
  }

  disableLoader() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }


  Future<void> callLogout() async {
    var data = await AuthenticationApi().logout();
    PreferenceManager().saveLogin(
      isLoggedIn: false,
    );
    PreferenceManager().saveToken(token: "");
    PreferenceManager().saveMobileNo(mobileNo: "");
    PreferenceManager().saveDriverJobId(driverJobId: 0);
    isLogoutLoading.value = false;
    isLoading.value = false;
    isLogoutLoading.value = false;
    CustomNavigator.pushReplace(Routes.LOGIN);
  }



}
