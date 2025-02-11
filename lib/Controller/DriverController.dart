import 'package:get/get.dart';
import 'package:timesheetgt/Model/DriverJobStartDataModel.dart';

import '../Model/CreateUserDataModel.dart';
import '../Model/SelectedFileModel.dart';
import '../Networking/DriverApi.dart';
import '../Routing/Util/AppRoutes.dart';
import '../Utils/CustomNavigator.dart';
import '../Utils/PreferenceManager.dart';
import '../Utils/ShowMessages.dart';
import 'AuthController.dart';

class DriverController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxString stErrorMsg = ''.obs;
  RxBool hasJobStarted = false.obs;
  RxList<String> ticketType = ["Deploy","Refuel","Retrieve"].obs;
  RxList<String> closeUpdated = ["Select","MATSGT","NFSD"].obs;
  RxString selTicketType = 'Deploy'.obs;
  RxString selCloseOrUpdated = 'Select'.obs;
  Rxn<CreateUserDataModel> createUserDataModel = Rxn<CreateUserDataModel>();
  Rxn<DriverJobStartDataModel> driverStartJobDataModel = Rxn<DriverJobStartDataModel>();
  RxBool isUpdateLoading = false.obs;
  RxList<SelectedFileModel> selectedFilesToUploadMob = RxList<SelectedFileModel>();
  AuthController authController = Get.put(AuthController());
  @override
  void onInit() {
    super.onInit();
  }

  Future<dynamic> deleteUser({jsonParam}) async {
    var data = await DriverApi().createUpdateUser(
        jsonData: jsonParam
    );
    print("data>>63>> $data");
    createUserDataModel.value = null;
    if(data != null) {
      createUserDataModel.value = data;
      if(createUserDataModel.value!.status =="0"){
        ShowMessages().showSnackBarGreen("", createUserDataModel.value!.msg);
        print("data>>63>> ${createUserDataModel.value!.status}");
      }else if(createUserDataModel.value!.status =="10") {
        ShowMessages().showSnackBarRed("", createUserDataModel.value!.msg);
        CustomNavigator.pushTo(Routes.LOGOUT);
      }else{
        ShowMessages().showSnackBarRed("", createUserDataModel.value!.msg);
      }
    }

  }

  Future<dynamic> driverJob({jsonParam,isJobStarted}) async {
    isLoading.value = true;
    var data = await DriverApi().driverJob(
        jsonData: jsonParam
    );
    print("data>>>> $data");
    if(data != null) {
      driverStartJobDataModel.value = data;
      if(driverStartJobDataModel.value!.status =="0"){
        if(isJobStarted){
          hasJobStarted.value = true;
          PreferenceManager().saveDriverJobId(driverJobId: driverStartJobDataModel.value!.data!.data![0].driverJobId);
        }else{
          hasJobStarted.value = false;
          PreferenceManager().saveDriverJobId(driverJobId: 0);
        }
        ShowMessages().showSnackBarGreen("", driverStartJobDataModel.value!.msg);
        print("data>>63>> ${driverStartJobDataModel.value!.status}");
      }else if(driverStartJobDataModel.value!.status =="10") {
        ShowMessages().showSnackBarRed("", driverStartJobDataModel.value!.msg);
        CustomNavigator.pushTo(Routes.LOGOUT);
      }else{
        ShowMessages().showSnackBarRed("", driverStartJobDataModel.value!.msg);
      }

    }

  }



}