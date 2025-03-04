import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timesheetgt/Pages/LoginEmail.dart';


import '../Controller/AuthController.dart';
import 'LoginPhone.dart';

class LoginEntryPoint extends StatefulWidget {
  const LoginEntryPoint({Key? key}) : super(key: key);

  @override
  State<LoginEntryPoint> createState() => _LoginEntryPointState();
}

class _LoginEntryPointState extends State<LoginEntryPoint> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool showCountryCodes = false;
  bool showFilteredList = false;
  bool showOtpButton = false;
  StreamSubscription<Uri>? _linkSubscription;
  AuthController authController = Get.put(AuthController());
  bool isTenant = false;

  Future<bool> onWillPop() async {
    if (showCountryCodes) {
      setState(() {
        showCountryCodes = false;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: ScreenTypeLayout.builder(
          mobile: (_) => const LoginEmail(),
          desktop: (_) => Container(),
          tablet: (_) => Container(),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (Get.parameters["organizationId"] != null) {
      isTenant = true;
    }
    if (Get.parameters["email"] != null) {
      _phoneController.text = Get.parameters["email"]!;
    }
    super.initState();
  }
}
