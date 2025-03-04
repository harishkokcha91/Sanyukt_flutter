import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheetgt/Controller/LoginController.dart';
import 'package:timesheetgt/Widgets/TextFieldPrimary.dart'; // Use TextFieldPrimary for email input
import '../Constants/Constants.dart';
import '../Controller/AuthController.dart';
import '../Routing/Util/BasicFunctions.dart';
import '../Routing/Util/Loader.dart';
import '../Widgets/PrimaryButton.dart';
import '../Utils/Spacers.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({Key? key}) : super(key: key);

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final TextEditingController emailController = TextEditingController(); // Changed to email controller
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  final LoginController loginController = Get.put(LoginController());
  bool validated = false;

  @override
  void initState() {
    super.initState();
    BasicFunctions.setStatusColorLight();
  }

  // Email validation function
  bool isValidEmail(String email) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
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
                      // LYBL logo
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

                      // Email text field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFieldPrimary(
                          controller: emailController,
                          label: "Email Address", // Changed to Email Address
                          labelStyle: theme.textTheme.titleSmall?.copyWith(
                              color: Constants.COLOR_PRIMARY_DARK,
                              fontWeight: FontWeight.w400),
                          hint: "Enter your email address", // Email hint
                          keyboardType: TextInputType.emailAddress,
                          isMandatory: true,
                          onChanged: (v) {
                            setState(() {
                              validated = isValidEmail(v.trim()); // Validate email format
                            });
                          },
                          suffixIcon: emailController.text.trim().isNotEmpty
                              ? InkWell(
                            onTap: () {
                              emailController.text = '';
                              authController.stErrorMsg.value = '';
                              setState(() {
                                validated = false;
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
                      responsiveHtSpacer(6),

                      // Invalid email error message
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

                      // Password field
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
                            fontSize: 14,
                          ),
                        ),
                      ),
                      responsiveHtSpacer(22),

                      // Login button
                      Obx(() {
                        return (loginController.isLoading.value)
                            ? const Loader()
                            : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: PrimaryButton(
                            height: 48,
                            onTap: !validated
                                ? null
                                : () async {
                              authController.stErrorMsg.value = '';
                              await loginController.callLoginEmail(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              FocusScope.of(context).unfocus();
                            },
                            buttonText: "Login",
                          ),
                        );
                      }),
                      responsiveHtSpacer(16),

                      // Terms & Conditions and Privacy Policy
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
                                letterSpacing: 1,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms & Conditions',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  launchUrl(Uri.parse('https://www.yogislogistics.com'));
                                },
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Constants.COLOR_PRIMARY_DARK,
                                letterSpacing: 1,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 12,
                                letterSpacing: 1,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  launchUrl(Uri.parse('https://yogislogistics.com/privacy-policy'));
                                },
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Constants.COLOR_PRIMARY_DARK,
                                letterSpacing: 1,
                                fontSize: 12,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      responsiveHtSpacer(12),

                      // Loader for country data
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
                        ),
                      )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),

                if (authController.isLoading.value)
                  Container(
                      color: Constants.COLOR_BACKGROUND,
                      height: Get.height,
                      width: Get.width,
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
