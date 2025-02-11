import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheetgt/Controller/LoginController.dart';
import 'package:timesheetgt/Widgets/TextFieldPrimary.dart';
import '../Constants/Constants.dart';
import '../Controller/AuthController.dart';
import '../Routing/Util/BasicFunctions.dart';
import '../Routing/Util/Loader.dart';
import '../Widgets/PrimaryButton.dart';
import '../Utils/Spacers.dart';
import '../Widgets/TextFieldMobile.dart';
import 'package:url_launcher/url_launcher.dart';
class LoginPhone extends StatefulWidget {
  const LoginPhone({Key? key}) : super(key: key);

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  final LoginController loginController = Get.put(LoginController());
  bool validated = false;

  @override
  void initState() {
    super.initState();
    BasicFunctions.setStatusColorLight();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Obx(() {
      return Scaffold(
        body: Container(
          color: Constants.COLOR_BACKGROUND,
          child: Center(
              child: Stack(children: [
            // input layout
            Align(
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [
                  responsiveHtSpacer(52),
                  //LYBL logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        width: Get.width / 2,
                        image: const AssetImage("assets/logo.png"),
                      ),
                    ],
                  ),
                  responsiveHtSpacer(70),
                  // sign in text
                  // Container(
                  //   alignment: Alignment.center,
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   color: Colors.white,
                  //   child: Text(
                  //     "Login",
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: theme.textTheme.headlineMedium?.copyWith(
                  //         fontWeight: FontWeight.w400,
                  //         color: Constants.COLOR_PRIMARY_DARK),
                  //   ),
                  // ),
                  // responsiveHtSpacer(40),

                  // email text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFieldMobile(
                      controller: mobileController,
                      label: "Mobile Number",
                      labelStyle: theme.textTheme.titleSmall?.copyWith(
                          color: Constants.COLOR_PRIMARY_DARK,
                          fontWeight: FontWeight.w400),
                      hint: "Enter your mobile number",
                      keyboardType: TextInputType.emailAddress,
                      maxLetterLength: 10,
                      isTextCapital: false,
                      isMandatory: true,
                      onChanged: (v){
                        if(v.trim().length ==10){
                          setState(() {
                            validated  = true;
                          });
                        }
                      },
                      suffixIcon: mobileController.text.trim().isNotEmpty
                          ? InkWell(
                              onTap: () {
                                mobileController.text = '';
                                authController.stErrorMsg.value = '';
                                setState(() {
                                  validated  = false;
                                });
                              },
                              child: const Icon(
                                Icons.close_outlined,
                                size: 20,
                                color: Colors.black,
                              ),
                            )
                          : null,
                    ),
                  ),
                  // Enter Email field
                  responsiveHtSpacer(6),

                  //Invalid email Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      authController.stErrorMsg.value,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  responsiveHtSpacer(6),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFieldPrimary(
                        controller: passwordController,
                        hint: "Enter your password",
                        label: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        isMandatory: true,
                      labelStyle: Get.theme.textTheme.titleMedium!.copyWith(
                        color: Constants.COLOR_PRIMARY,
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                      ),

                    ),
                  ),
                  responsiveHtSpacer(22),
                  // Login button
                  Obx(() {
                      return (loginController.isLoading.value)?const Loader():Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PrimaryButton(
                          height: 48,
                          onTap: !validated
                              ? null
                              : () async {
                                  // await authController.generateToken();
                                  if (mobileController.text.trim().length == 10) {
                                    authController.stErrorMsg.value = '';
                                    await loginController.callLogin(
                                      mobileNo: mobileController.text.trim(),
                                      password: passwordController.text.trim()
                                    );
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    authController.stErrorMsg.value =
                                        "The mobile number you entered seems incorrect. Please try again.";
                                    setState(() {
                                      validated = false;
                                    });
                                    // ShowMessages().showSnackBarRed("Invalid Email ID", "Please enter a valid email address");
                                  }
                                },
                          buttonText: "Login",
                        ),
                      );
                    }
                  ),
                  responsiveHtSpacer(16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'By continuing, you agree to our ',
                              style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 12,
                                  letterSpacing: 1)),
                          TextSpan(
                              text: 'Terms & Conditions',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  launchUrl(Uri.parse(
                                      'https://www.yogislogistics.com'));
                                },
                              style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Constants.COLOR_PRIMARY_DARK,
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  // decoration: TextDecoration.underline,
                              )),
                          TextSpan(
                              text: ' and ',
                              style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 12,
                                  letterSpacing: 1)),
                          TextSpan(
                              text: 'Privacy Policy',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  launchUrl(Uri.parse(
                                      'https://yogislogistics.com/privacy-policy'));
                                },
                              style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Constants.COLOR_PRIMARY_DARK,
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  // decoration: TextDecoration.underline
                              )),
                        ])),
                  ),
                  responsiveHtSpacer(12),
                  authController.isLoadingCountries.value
                      ? Container(
                          height: Get.height,
                          width: Get.width,
                          color: Constants.COLOR_BACKGROUND,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    width: Get.width / 3,
                                    image: const AssetImage("assets/logo.png"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Loader()
                            ],
                          ))
                      : const SizedBox.shrink(),
                ],
              ),
            ),

            if (authController.isLoading.value)
              Container(
                  color: Constants.COLOR_BACKGROUND,
                  height: Get.height,
                  width: Get.width,
                  // color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Image(
                              width: Get.width / 2,
                              image: const AssetImage("assets/logo.png"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Loader()
                    ],
                  ))
          ])),
        ),
      );
    });
  }

}
