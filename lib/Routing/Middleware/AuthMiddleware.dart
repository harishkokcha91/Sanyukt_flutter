import 'package:get/get.dart';

import '../../Utils/CustomNavigator.dart';
import '../../Utils/PreferenceManager.dart';
import '../Util/AppRoutes.dart';


class AuthMiddleware extends GetMiddleware {

  @override
  GetPage? onPageCalled(GetPage? page) {
    print("page>>> ${page?.name}");
      if (page?.parameters!['accessToken'] != null) {
        print('its called 15');
        String? stToken = page?.parameters!['accessToken'].toString();
        String? stUserMobile = page?.parameters!['mobile'].toString();
        prefServices.saveToken(token: stToken);
        prefServices.saveMobileNo(mobileNo: stUserMobile);
        prefServices.saveLogin(isLoggedIn: true);
      }

      checkIfAuthenticated(page?.name ?? "");
    return super.onPageCalled(page);
  }

  checkIfAuthenticated(String url) async {
    bool isLogin = await PreferenceManager().getLogin();
    var token = PreferenceManager().getToken();
    if (!isLogin || token.isEmpty) {
      CustomNavigator.pushReplace(Routes.LOGIN);
    } else {
      CustomNavigator.pushReplace(Routes.HOME);
    }
  }

}
