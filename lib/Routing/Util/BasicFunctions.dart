import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import '../../Constants/Constants.dart';

class BasicFunctions {

  static setStatusColorLight() {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Constants.COLOR_BACKGROUND, //
          statusBarIconBrightness: Brightness.dark
      ));
  }

  static setStatusColorDark() {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Constants.COLOR_BACKGROUND, //
          statusBarIconBrightness: Brightness.dark));
  }

}
