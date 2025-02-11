import 'package:dio/dio.dart';
import '../Constants/ApiEndPoints.dart';
import '../Model/AuthResonseModel.dart';
import '../Utils/GetDio.dart';

class AuthenticationApi {
  var dio = GetDio().getDio();


  //Login
  Future<dynamic> login({jsonData}) async {
    print("Logout from api logout.......................${ApiEndPoints.loginURL}");
    try {
      Response response = await dio.post(
        ApiEndPoints.loginURL,
        data: jsonData
      );
      print('qwertyu>>logout> ${response.data} ${ApiEndPoints.loginURL}');
      return AuthResponseModel.fromJson(response.data);
    } catch (e) {
      print("error>>> ${e.toString()}");
      return null;
    }
  }



  //Logout
  Future<dynamic> logout() async {
    try {
      var jsonParam = {
        "userid": 1,
        "usertime": "${DateTime.now()}",
        "spmode": 0,
        "req_frm": 1
      };
      Response response = await dio.post(
          ApiEndPoints.logoutUrl,
          data: jsonParam
      );
      print('qwertyu>>logout> ${response.data} ${ApiEndPoints.logoutUrl}');
    } catch (e) {
      print("error>>> ${e.toString()}");
      return null;
    }
  }

}
