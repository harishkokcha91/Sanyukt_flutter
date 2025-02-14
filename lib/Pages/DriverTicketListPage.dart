import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheetgt/Controller/DriverController.dart';
import '../Constants/Constants.dart';
import '../Routing/Util/AppRoutes.dart';
import '../Routing/Util/Loader.dart';
import '../Utils/CustomNavigator.dart';
import '../Utils/PreferenceManager.dart';
import '../Utils/Spacers.dart';
import '../Widgets/BorderButton.dart';
import '../Widgets/ParentWidgetMobile.dart';
import '../Widgets/PrimaryButton.dart';
import 'package:intl/intl.dart';

class DriverTicketListPage extends StatefulWidget {
  const DriverTicketListPage({super.key});

  @override
  State<DriverTicketListPage> createState() => _DriverTicketListPageState();
}

class _DriverTicketListPageState extends State<DriverTicketListPage> {
  DriverController driverController = Get.put(DriverController());

  askForDeleteUser() {
    Get.dialog(
      AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Delete Account?",
              style: Get.theme.textTheme.displaySmall
                  ?.copyWith(
                  fontWeight: FontWeight.w400),
            ),
            CustomSpacers.height16,
            Text(
                "Are you sure you want to delete your account? This action is permanent and will remove all your data from our system. We will no longer retain any of your information after deletion. This cannot be undone.",
              textAlign: TextAlign.center,
              style: Get.theme.textTheme.titleMedium
                  ?.copyWith(
                  fontWeight: FontWeight.w400),
            ),
            CustomSpacers.height16,
            Obx(() {
              return (driverController.isUpdateLoading.value)?Loader():Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BorderButton(
                    onTap: (){
                      Get.back();
                    },
                    buttonText: "No",
                    hasPrimaryOnRight: true,
                  ),

                  PrimaryButton(
                    onTap: () async{
                      driverController.isUpdateLoading.value = true;
                      var jsonParam = {
                        "userid": int.parse(PreferenceManager().getUserId()),
                        "usrname": "",
                        "usertype": 1,
                        "password": "",
                        "address": "",
                        "bank_acc_details": "",
                        "mobileno": "",
                        "created_by": int.parse(PreferenceManager().getUserId()),
                        "usertime": "${DateTime.now().toIso8601String()}Z",
                        "status_id": 2,
                        "spmode": 1
                      };
                      await driverController.deleteUser(jsonParam: jsonParam);
                      driverController.isUpdateLoading.value = false;
                      CustomNavigator.pushTo(Routes.LOGOUT);
                    },
                    buttonText: "Proceed",
                  )
                ],
              );
            }
            ),

          ],
        ),
      ),
      barrierDismissible: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return ParentWidgetMobile(
      layout: Scaffold(
        body: Container(
          color: Constants.COLOR_BACKGROUND_LIGHT,
          padding: const EdgeInsets.only(left: 16.0,right: 16),
          child: Obx(() {
            return (driverController.isLoading.value)?Loader()
                :ListView(
                  shrinkWrap: true,
                  children: [
                    CustomSpacers.height32,
                    ListView.builder(
                      itemCount: 15,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Constants.COLOR_PRIMARY,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat("dd MMM, yyyy").format(DateTime.now()),
                                      style: Get.theme.textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Naranul",
                                          style: Get.theme.textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18
                                          ),
                                        ),
                                        const Icon(
                                          Icons.navigation_rounded,
                                          color: Constants.COLOR_PRIMARY,
                                          size: 24,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                CustomSpacers.height8,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "#M12345678",
                                      style: Get.theme.textTheme.titleMedium!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18
                                      ),
                                    ),
                                    Text(
                                      "#M12345678",
                                      style: Get.theme.textTheme.titleMedium!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ],
                                ),
                                CustomSpacers.height8,

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "FA Code",
                                          style: Get.theme.textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18
                                          ),
                                        ),
                                        vSpacer(2),
                                        Text(
                                          "1234543567",
                                          style: Get.theme.textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16
                                          ),
                                        ),
                                      ],
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mats Id",
                                          style: Get.theme.textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18
                                          ),
                                        ),
                                        vSpacer(2),
                                        Text(
                                          "989888",
                                          style: Get.theme.textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),




                              ],
                            )
                          );
                        },
                    ),

                    CustomSpacers.height24,
              ],
            );
          }
          ),
        ),
      ),
      widget1: PopupMenuButton<String>(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
        offset: const Offset(0, kToolbarHeight-24),
        constraints: BoxConstraints(),
        onSelected: (value)  async{
          if(value == "Logout"){
            CustomNavigator.pushTo(Routes.LOGOUT);
          }else if(value == "Delete Account"){
            askForDeleteUser();
          }
        },
        itemBuilder: (BuildContext context) {
          return {"Logout","Delete Account"}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              height: 18,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    if(choice == "Logout")...[
                      const Icon(
                        Icons.logout,
                        color: Constants.COLOR_PRIMARY,
                        size: 24,
                      )],
                    if(choice == "Delete Account")...[
                      const Icon(
                        Icons.delete,
                        color: Constants.COLOR_PRIMARY,
                        size: 24,
                      )],

                    const SizedBox(width: 6),
                    Text(
                      choice,
                      style: Get.theme.textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList();
        },
      ),
      showBackButton: false,
      title: "Hi, ${PreferenceManager().getUserName()}",
    );
  }
}
