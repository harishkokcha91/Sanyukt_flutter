import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Model/ProfileResponse.dart';
import '../Networking/ProfileApi.dart';
import '../Utils/CustomNavigator.dart';
import '../Utils/ShowMessages.dart';
import '../Routing/Util/AppRoutes.dart';

class ProfileController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> createProfile(Map<String, dynamic> profileData) async {
    isLoading.value = true;
    var data = await ProfileApi().createProfile(jsonData: profileData);
    isLoading.value = false;

    if (data != null) {
      ShowMessages().showSnackBarGreen("Success", "Profile created successfully.");
      // CustomNavigator.pushReplace(Routes.PROFILE_LIST);
    } else {
      ShowMessages().showSnackBarRed("Error", "Failed to create profile. Try again.");
    }
  }

  Future<ProfileResponse?> fetchProfiles({int page = 1, int limit = 10}) async {
    print("fetchProfiles ProfileController");
    isLoading.value = true;
    var data = await ProfileApi().getProfiles(page: page, limit: limit);
    isLoading.value = false;
    if (data != null) {
      print("Profiles fetched successfully: ${data}");
        // Parse response using ProfileResponse model
        ProfileResponse profileResponse = profileResponseFromJson(json.encode(data));
        return profileResponse; // Return parsed response
    } else {
      ShowMessages().showSnackBarRed("Error", "Failed to fetch profiles.");
      return null;
    }
  }

  Future<void> updateProfile(int profileId, Map<String, dynamic> profileData) async {
    isLoading.value = true;
    var data = await ProfileApi().updateProfile(profileId, jsonData: profileData);
    isLoading.value = false;

    if (data != null) {
      ShowMessages().showSnackBarGreen("Success", "Profile updated successfully.");
      // CustomNavigator.pushReplace(Routes.PROFILE_LIST);
    } else {
      ShowMessages().showSnackBarRed("Error", "Failed to update profile.");
    }
  }

  Future<void> deleteProfile(int profileId) async {
    isLoading.value = true;
    var success = await ProfileApi().deleteProfile(profileId);
    isLoading.value = false;

    if (success) {
      ShowMessages().showSnackBarGreen("Success", "Profile deleted successfully.");
    } else {
      ShowMessages().showSnackBarRed("Error", "Failed to delete profile.");
    }
  }
}
