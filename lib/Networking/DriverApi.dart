import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:timesheetgt/Model/DriverJobStartDataModel.dart';
import 'package:timesheetgt/Utils/ShowMessages.dart';
import '../Constants/ApiEndPoints.dart';
import '../Model/AuthResonseModel.dart';
import '../Model/CreateUserDataModel.dart';
import '../Utils/GetDio.dart';

class DriverApi {
  var dio = GetDio().getDio();

  Future<void> uploadImage({selectedImage,driverJobId,driverId}) async {
    if (selectedImage == null) return;
    try {
      FormData formData = FormData.fromMap({
        "driver_job_id":driverJobId,
        "driver_id":driverId,
        "spmode":0,
        "": await MultipartFile.fromFile(
          selectedImage!.path,
          filename: selectedImage!.path.split('/').last,
        ),
      });

      Dio dio = Dio();
      Response response = await dio.post(ApiEndPoints.imageUploadUrl, data: formData);
      print("response>>> $response");
      if (response.statusCode == 200) {
        // ShowMessages().showSnackBarGreen("", "Image uploaded successfully!");
      } else {
        ShowMessages().showSnackBarGreen("", "Failed to upload image.");
      }
    } catch (e) {
      ShowMessages().showSnackBarGreen("", e.toString());

    }
  }

  Future<dynamic> createUpdateUser({jsonData}) async {
    try {
      Response response = await dio.post(
          ApiEndPoints.createUpdateUserUrl,
          data: jsonData
      );
      print('qwertyu>>startJob> ${response.data} ${ApiEndPoints.createUpdateUserUrl}');
      return CreateUserDataModel.fromJson(response.data);
    } catch (e) {
      print("error>>> ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> driverJob({jsonData}) async {
    try {
      Response response = await dio.post(
          ApiEndPoints.jobURL,
          data: jsonData
      );
      print('qwertyu>>startJob> ${response.data} ${ApiEndPoints.jobURL}');
      return DriverJobStartDataModel.fromJson(response.data);
    } catch (e) {
      print("error>>> ${e.toString()}");
      return null;
    }
  }



}
