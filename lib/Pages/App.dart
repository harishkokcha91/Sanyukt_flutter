import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Constants/Constants.dart';
import '../Controller/AuthController.dart';
import '../Routing/Util/AppPages.dart';
import '../Utils/AppTheme.dart';
import '../Utils/CustomNavigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final CustomNavigator routeManager = CustomNavigator();

  MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme();
    ScreenUtil.init(context);
    return GetMaterialApp(
      // navigatorKey: routeManager.navigatorKey,
      navigatorKey: Get.key,
      popGesture: Get.isPopGestureEnable,
      opaqueRoute: Get.isOpaqueRouteDefault,
      title: 'Lybl',
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put<AuthController>(AuthController());
      }),
      theme: ThemeData(
          primaryColorDark: Constants.COLOR_PRIMARY,
          primaryColorLight: Constants.COLOR_SUCCESS_LIGHT,
          splashColor: Colors.white,
          colorScheme:  ColorScheme.fromSeed(
            surfaceTint: Colors.transparent,
            onSecondary: Constants.COLOR_SUCCESS_LIGHT,
            seedColor:  Constants.COLOR_PRIMARY,
            background: Colors.white,
            onPrimary: Constants.COLOR_SUCCESS_LIGHT,
          ),

          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                overlayColor: MaterialStatePropertyAll(Constants.COLOR_SUCCESS_LIGHT),
              )
          ),
          fontFamily: 'SfProDisplay',
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Constants.COLOR_PRIMARY,
          indicatorColor: Constants.COLOR_PRIMARY,
          sliderTheme:  SliderThemeData(
            valueIndicatorColor: Colors.white,
            valueIndicatorStrokeColor: Constants.COLOR_SUCCESS_LIGHT,
            activeTickMarkColor: Colors.red,
            thumbColor: Colors.red,
            activeTrackColor: Constants.COLOR_SUCCESS_LIGHT,
            inactiveTrackColor: Colors.black12,
          ),
          scrollbarTheme: ScrollbarThemeData(
              trackColor: MaterialStatePropertyAll(Constants.COLOR_PRIMARY),
              thumbColor: MaterialStatePropertyAll(Constants.COLOR_PRIMARY)
          ),
          switchTheme: SwitchThemeData(
            trackColor: MaterialStatePropertyAll(Constants.COLOR_PRIMARY),
            thumbColor: const MaterialStatePropertyAll(Colors.white),
            trackOutlineColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.5)),
            trackOutlineWidth: const MaterialStatePropertyAll(0.5),
          ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color:Constants.COLOR_PRIMARY,
          ),
          radioTheme: RadioThemeData(
            //fillColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.4)),
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return Constants.COLOR_PRIMARY;
              }
              return  Colors.black.withOpacity(0.4);
            }),
            overlayColor:const MaterialStatePropertyAll(Colors.transparent),
            // overlayColor: MaterialStatePropertyAll(Colors.black12),
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          tooltipTheme: const TooltipThemeData(
            textStyle: TextStyle(
                color: Colors.black
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              boxShadow: [
                BoxShadow(color: Colors.grey,
                  blurRadius: 20.0,
                  offset: Offset(12.0, 12.0),
                ), //BoxShadow
              ],
              color: Colors.white,

            ),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Constants.COLOR_PRIMARY,
            selectionColor: Constants.COLOR_BACKGROUND,
          ),
          chipTheme: const ChipThemeData(
            backgroundColor: Color(0xFFF3F3F3),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                side: BorderSide.none
            ),
          ),
          datePickerTheme: DatePickerThemeData(
            surfaceTintColor: Colors.transparent,
            shadowColor: Constants.COLOR_SUCCESS_LIGHT,
            dayOverlayColor: MaterialStatePropertyAll(Constants.COLOR_SUCCESS_LIGHT),
            backgroundColor: Colors.white,
            headerBackgroundColor: Constants.COLOR_PRIMARY,
            headerForegroundColor: Colors.white,
            todayBorder: BorderSide(
              color:Constants.COLOR_PRIMARY,
            ),
            cancelButtonStyle: const ButtonStyle(
                textStyle: MaterialStatePropertyAll(TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),)
            ),
            confirmButtonStyle: const ButtonStyle(
                textStyle: MaterialStatePropertyAll(TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ))
            ),


          ),
          timePickerTheme: TimePickerThemeData(
            dialBackgroundColor: Constants.COLOR_SUCCESS_LIGHT,
            backgroundColor: Colors.white,
            dialHandColor: Constants.COLOR_PRIMARY,
            hourMinuteColor: Constants.COLOR_PRIMARY,
            hourMinuteTextColor: Colors.white,
            hourMinuteTextStyle: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400
            ),
            cancelButtonStyle: const ButtonStyle(
                textStyle: MaterialStatePropertyAll(TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),)
            ),
            confirmButtonStyle: const ButtonStyle(
                textStyle: MaterialStatePropertyAll(TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ))
            ),
            dayPeriodColor: Constants.COLOR_PRIMARY.withOpacity(0.6),



          ),
          popupMenuTheme: const PopupMenuThemeData(
            color: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
          dialogTheme: const DialogTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
          dropdownMenuTheme: const DropdownMenuThemeData(
              menuStyle: MenuStyle(
                backgroundColor:MaterialStatePropertyAll(Colors.white),
              )
          ),
          checkboxTheme: CheckboxThemeData(
            checkColor: const MaterialStatePropertyAll(Colors.white),
            overlayColor:const MaterialStatePropertyAll(Colors.transparent),
            side: BorderSide(
                width: 2,
                color: Colors.black.withOpacity(0.4)
            ),
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          tabBarTheme: TabBarTheme(
              indicatorColor: Constants.COLOR_PRIMARY,
              overlayColor: MaterialStatePropertyAll(Constants.COLOR_SUCCESS_LIGHT)
          ),
          dividerTheme: const DividerThemeData(
              thickness: 1,
              color: Constants.HINT_PRIMARY
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Constants.COLOR_PRIMARY),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  shadowColor: MaterialStateProperty.all<Color>(Constants.COLOR_SUCCESS_LIGHT),
                  surfaceTintColor: MaterialStateProperty.all<Color>(Constants.COLOR_SUCCESS_LIGHT),
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  textStyle: const MaterialStatePropertyAll(
                      TextStyle(fontSize: 16.0, color: Colors.white)))),
          appBarTheme: AppBarTheme(
              backgroundColor: Constants.COLOR_PRIMARY,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black, size: 18),
              titleTextStyle: appTheme.textTheme.titleMedium),
          textTheme: appTheme.textTheme),
      initialRoute: AppPages.INITIAL,
      getPages:AppPages.routes,
      // home: OnDemandConsultationMain(),
      // home: CategoryIntro(),
      //  home: QNRIntroPage(),
      // home:MCQPage()
      // home: const CreateProfileDoctor(showNavBar: false, phone: "9468506570"),
      // home: const HomeContainerDoctor(),
    );
  }
}
