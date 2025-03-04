import 'package:dio/dio.dart';
import 'package:timesheetgt/Model/ProfileResponse.dart';
import '../Constants/ApiEndPoints.dart';
import '../Utils/GetDio.dart';

class ProfileApi {
  var dio = GetDio().getDio();

  // Create a new matrimonial profile
  Future<dynamic> createProfile({required Map<String, dynamic> jsonData}) async {
    try {
      Response response = await dio.post(
        ApiEndPoints.createProfileUrl,
        data: jsonData,
      );
      return ProfileResponse.fromJson(response.data);
    } catch (e) {
      print("Error creating profile: ${e.toString()}");
      return null;
    }
  }

  // Get list of matrimonial profiles
  Future<dynamic> getProfiles({int page = 1, int limit = 10}) async {
    print("getProfiles ProfileAPi ${ApiEndPoints.getProfilesUrl}?page=$page&limit=$limit");
    try {
      Response response = await dio.get(
        "${ApiEndPoints.getProfilesUrl}?page=$page&limit=$limit",
      );
      return response.data;
    } catch (e) {
      print("Error fetching profiles: ${e.toString()}");
      return null;
    }
  }

  // Get profile by user ID
  Future<dynamic> getProfilesByUserId(int userId, {int page = 1, int limit = 10}) async {
    try {
      Response response = await dio.get(
        "${ApiEndPoints.getProfilesByUserIdUrl}/$userId?page=$page&limit=$limit",
      );
      return response.data;
    } catch (e) {
      print("Error fetching profiles by user ID: ${e.toString()}");
      return null;
    }
  }

  // Get a matrimonial profile by profile ID
  Future<dynamic> getProfileById(int profileId) async {
    try {
      Response response = await dio.get(
        "${ApiEndPoints.getProfileByIdUrl}/$profileId",
      );
      return response.data;
    } catch (e) {
      print("Error fetching profile: ${e.toString()}");
      return null;
    }
  }

  // Update a matrimonial profile by ID
  Future<dynamic> updateProfile(int profileId, {required Map<String, dynamic> jsonData}) async {
    try {
      Response response = await dio.put(
        "${ApiEndPoints.updateProfileUrl}/$profileId",
        data: jsonData,
      );
      return response.data;
    } catch (e) {
      print("Error updating profile: ${e.toString()}");
      return null;
    }
  }

  // Delete a matrimonial profile by ID
  Future<dynamic> deleteProfile(int profileId) async {
    try {
      Response response = await dio.delete(
        "${ApiEndPoints.updateProfileUrl}/$profileId",
      );
      return response.data;
    } catch (e) {
      print("Error deleting profile: ${e.toString()}");
      return null;
    }
  }
}
