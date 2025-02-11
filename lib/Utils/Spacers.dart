import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget vSpacer([double height = 24]) =>SizedBox(
        height: height);

Widget hSpacer([double width = 24]) => SizedBox(
        width: width);

Widget responsiveHtSpacer([double height = 16]) =>
    SizedBox(height: height);

Widget responsiveWidthSpacer([double width = 16]) =>
    SizedBox(width: width);

Widget responsiveHtWebSpacer([double height = 16, Key? key]) =>
    SizedBox(key: key, height: height);

Widget responsiveWidthWebSpacer([double width = 16, Key? key]) =>
    SizedBox(width: width);

class CustomSpacers {
  static final height4 = vSpacer(4);


  static final height6 = vSpacer(6);

  static final height8 =vSpacer(8);

  static final height10 = vSpacer(10);

  static final height12 = vSpacer(12);


  static final height14 = vSpacer(14);

  static final height16 = vSpacer(16);

  static final height18 = vSpacer(18);

  static final height20 = vSpacer(20);

  static final height22 = vSpacer(22);

  static final height24 = vSpacer(24);

  static final height48 = vSpacer(48);

  static final height28 = vSpacer(28);

  static final height32 = vSpacer(32);

  static final height36 = vSpacer(36);

  static final height44 = vSpacer(44);

  static final height60 = vSpacer(60);

  static final height114 = vSpacer(114);

  static final width4 = hSpacer(4);

  static final width6 = hSpacer(6);

  static final width8 = hSpacer(8);
  static final width10 = hSpacer(10);
  static final width12 = hSpacer(12);
  static final width16 = hSpacer(16);
  static final width20 = hSpacer(20);
  static final width24 = hSpacer(24);
  static final width28 = hSpacer(28);
  static final width32 = hSpacer(32);

  static final width36 = hSpacer(36);
  static final width50 = hSpacer(50);

  static final width14 = hSpacer(14);
}
