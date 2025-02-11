import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../Constants/Constants.dart';
import '../Controller/AuthController.dart';
import '../Utils/Spacers.dart';



class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AuthController authController = Get.find<AuthController>();
  bool isLoading = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (_) => mobileLayout(),
      mobile: (_) => mobileLayout(),
    );
  }
  mobileLayout(){
    return Scaffold(
      body: Center(
        child: Image.asset("assets/logo.png",
            fit: BoxFit.cover
        ),
      ),
    );
  }

  checkLogin() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      authController.checkIfLoggedIn();
    });
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }
}
