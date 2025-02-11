import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ShowMessages {
  void showSnackBarRed(title, message) async {
    if (!Get.isSnackbarOpen) {
      Get.snackbar('', message,
        padding: const EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 14),
        backgroundColor: const Color(0xFF525252).withOpacity(1),
        colorText: Colors.white,
        duration: const Duration(milliseconds: 3000),
        snackPosition: kIsWeb ? SnackPosition.TOP : SnackPosition.BOTTOM,
        maxWidth: kIsWeb ? 400 : Get.width,
        titleText: const SizedBox.shrink(),
        margin: const EdgeInsets.all(30),
        borderRadius: 6,
        animationDuration: const Duration(microseconds: 5000),

      );
    }
  }

  void showSnackBarGreen(title, message) async {
    Get.snackbar('', message,
        padding: const EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 14),
        backgroundColor: Color(0xFF525252).withOpacity(1),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        snackPosition: kIsWeb ? SnackPosition.TOP : SnackPosition.BOTTOM,
        maxWidth: kIsWeb ? 400 : Get.width,
        titleText: const SizedBox.shrink(),
        margin: const EdgeInsets.all(30),
        borderRadius: 6,
      animationDuration: const Duration(microseconds: 5000),

    );
  }
}


