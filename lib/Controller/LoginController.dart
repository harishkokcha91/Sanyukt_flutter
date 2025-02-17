import 'dart:convert';

import 'package:get/get.dart';
import 'package:timesheetgt/Routing/Util/AppRoutes.dart';
import 'package:timesheetgt/Utils/CustomNavigator.dart';
import 'package:timesheetgt/Utils/ShowMessages.dart';
import '../Model/AuthResonseModel.dart';
import '../Networking/AuthenticationApi.dart';
import '../Utils/PreferenceManager.dart';
import 'package:intl/intl.dart';

class LoginController extends GetxController with StateMixin {

  RxBool isLoading = false.obs;
  Rxn<AuthResponseModel> loginRes = Rxn<AuthResponseModel>();

  @override
  void onInit() {
    super.onInit();
  }


  Future<void> callLogin({mobileNo,password}) async {
    var jsonParam = {
      "mobileno": "$mobileNo",
      "password": "$password",
      "usertype": "1",
      "latitude": "",
      "longitude":"",
      "location": "",
      "usertime": DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      "spmode": 0,
      "req_frm": 1
    };
    print("jsonParam>>>> ${jsonEncode(jsonParam)}");
    isLoading.value = true;
    var data = await AuthenticationApi().login(
      jsonData: jsonParam
    );
    print("data>>>> $data");
    if(data != null) {
      loginRes.value = data;
      if(loginRes.value!.status == "0") {
        print("loginRes.value>>>> $loginRes.value");
        PreferenceManager().saveLogin(isLoggedIn: true);
        PreferenceManager().saveToken(
            token: loginRes.value!.data!.data![0].tokenid);
        PreferenceManager().saveMobileNo(mobileNo: mobileNo);
        PreferenceManager().saveUserName(
            username: loginRes.value!.data!.data![0].username);
        PreferenceManager().saveUserId(
            userId: loginRes.value!.data!.data![0].userid.toString());
        CustomNavigator.pushReplace(Routes.HOME);
      }else{
        ShowMessages().showSnackBarRed("",loginRes.value!.msg);
      }
      isLoading.value = false;
    }

  }

}