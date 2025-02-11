import 'package:get_storage/get_storage.dart';


final prefServices = PreferenceManager();

class PreferenceManager {
  final storage = GetStorage();


  saveLogin({required bool isLoggedIn}) async {
    storage.write('isLoggedIn', isLoggedIn);
  }

  Future<bool> getLogin() async {
    return storage.read('isLoggedIn') ?? false;
  }


  saveDeviceId({required String? deviceId}) async {
    storage.write('deviceId', deviceId);
  }

  String getDeviceId() {
    return storage.read('deviceId') ?? "";
  }

  saveUniqueId({required String? uniqueId}) async {
    storage.write('uniqueId', uniqueId);
  }

  String getUniqueId() {
    return storage.read('uniqueId') ?? "";
  }

  saveToken({required String? token}) async {
    storage.write('token', token);
  }

  String getToken() {
    return storage.read('token') ?? "";
  }

  saveDriverJobId({required int? driverJobId}) async {
    storage.write('driverJobId', driverJobId);
  }

  int getDriverJobId() {
    return storage.read('driverJobId') ?? 0;
  }

  saveMobileNo({required String? mobileNo}) async {
    storage.write('mobileNo', mobileNo);
  }

  String getMobileNo() {
    return storage.read('mobileNo') ?? "";
  }

  saveUserName({required String? username}) async {
    storage.write('username', username);
  }

  String getUserName() {
    return storage.read('username') ?? "";
  }

  saveUserId({required String? userId}) async {
    storage.write('userId', userId);
  }

  String getUserId() {
    return storage.read('userId') ?? "";
  }

}
