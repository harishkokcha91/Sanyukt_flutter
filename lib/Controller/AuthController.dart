import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheetgt/Controller/DriverController.dart';
import '../Model/DriverJobFormDataModel.dart';
import '../Networking/AuthenticationApi.dart';
import '../Routing/Util/AppRoutes.dart';
import '../Utils/CustomNavigator.dart';
import '../Utils/PreferenceManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<DriverJobFormDataModel?> getDriverJobFormData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('driverJobFormData');

    if (jsonString == null) return null; // Return null if no data is found

    Map<String, dynamic> jsonMap = jsonDecode(jsonString); // Decode JSON
    return DriverJobFormDataModel.fromJson(jsonMap);
  }

  checkIfLoggedIn() async {
    bool isLogin = await PreferenceManager().getLogin();
    if (isLogin) {
        DriverJobFormDataModel? driverJobFormDataModel = await getDriverJobFormData();
        if(driverJobFormDataModel !=  null) {
          var jsonParam = {
            "driver_job_id": driverJobFormDataModel.driverJobId??'',
            "site_name": driverJobFormDataModel.siteName??"",
            "req_frm": 0,
            "ticket_number": driverJobFormDataModel.ticketNumber??"",
            "child_ticket": driverJobFormDataModel.childTicketNumber??"",
            "fa_code": driverJobFormDataModel.faCode??"",
            "ticket_type": driverJobFormDataModel.ticketType??"",
            "gallons": driverJobFormDataModel.gallonInGenerator??"",
            "generator_hr": driverJobFormDataModel.generatorHr??"",
            "generator_min": driverJobFormDataModel.generatorMin??"",
            "mats_id": driverJobFormDataModel.matsId??"",
            "closed_or_updated": (driverJobFormDataModel.selCloseOrUpdated == "Select") ? ""
                : driverJobFormDataModel.selCloseOrUpdated,
            "gallons_in_truck": driverJobFormDataModel.gallonInTruck,
            "price_per_gal_for_truck": driverJobFormDataModel.pricePerGallon,
            "price_per_gal_for_generator": driverJobFormDataModel.pricePerGallonGenerator,
            "status_id": 0,
            "job_user_end_time": driverJobFormDataModel.jobStartTime,
            "job_user_start_time": driverJobFormDataModel.jobEndTime,
            "job_start_longitude": "",
            "job_start_latitude": "",
            "job_start_location": "",
            "job_end_location": "",
            "job_end_longitude": driverJobFormDataModel.userLong??"",
            "job_end_latitude": driverJobFormDataModel.userLat??"",
            "job_start_ip_address": "",
            "job_end_ip_address": "",
            "description": driverJobFormDataModel.description??"",
            "created_by": int.parse(PreferenceManager().getUserId()),
            "user_time": driverJobFormDataModel.jobEndTime,
            "documents": "",
            "spmode": 0
          };
          print("jsonParam>>>> $jsonParam");
          await Get.put(DriverController()).driverJob(
              jsonParam: jsonParam,
              isJobStarted: false);
        }
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
