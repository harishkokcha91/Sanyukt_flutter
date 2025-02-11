import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Controller/AuthController.dart';
import '../Routing/Util/AppRoutes.dart';
import '../Routing/Util/BasicFunctions.dart';
import '../Routing/Util/Loader.dart';
import '../Utils/CustomNavigator.dart';
import '../Utils/Spacers.dart';
import 'package:get/get.dart';

class LogoutWeb extends StatefulWidget {
  const LogoutWeb({Key? key}) : super(key: key);

  @override
  State<LogoutWeb> createState() => _LogoutWebState();
}

class _LogoutWebState extends State<LogoutWeb> {

  AuthController authController = Get.put(AuthController());


  logout(){
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      BasicFunctions.setStatusColorLight();
      await authController.callLogout();
      Future.delayed(const Duration(milliseconds: 1500), () {
        CustomNavigator.pushReplace(Routes.LOGIN);
      });

    });
  }

  @override
  void initState() {
    super.initState();
    logout();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Logging Out",
              style: theme.textTheme.titleMedium!.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w500
              ),
            ),
            CustomSpacers.height4,
            Text("Please wait...",
              style: theme.textTheme.titleMedium!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w400
              ),
            ),
            CustomSpacers.height14,
            const Center(
              child: Loader())

          ],
        ),
      ),
    );
  }
}
