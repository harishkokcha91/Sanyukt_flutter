import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<bool> locationPermissionsGranted() async {
    if (await Permission.location.serviceStatus.isDisabled) {
      return false;
    }
    var permission = await Permission.location.status;
    if (permission.isPermanentlyDenied) {
      // await AppSettings.openAppSettings();
    } else if (await Permission.location.status.isGranted) {
      return true;
    } else {
      permission = await Permission.location.request();
    }
    return permission.isGranted;
  }


}