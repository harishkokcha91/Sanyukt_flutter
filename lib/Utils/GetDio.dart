import 'package:dio/dio.dart' as dioLib;
import 'PreferenceManager.dart';

class GetDio {
  dioLib.Dio getDio() {
    String token = PreferenceManager().getToken();
    String userId = PreferenceManager().getUserId();

    dioLib.Dio dio = dioLib.Dio();
    dio.options.headers["tokenId"] = token;
    dio.options.headers["userId"] = userId;
    dio.options.headers["content-type"] = "application/json";
    dio.options.headers["accept"] = "application/json";
    return dio;
  }
}
