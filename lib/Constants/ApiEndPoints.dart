
class ApiEndPoints {
  static const String baseUrl = "https://app.timesheetgt.com/API.asmx/";
  static const String googleAPIKey = "AIzaSyCkRGFWU4lTsmqAqrCyzOwvWHVgxgMqH_0";
  static const String localHostBaseUrl = "http://192.168.1.82:8084/"; //for android
  // static const String localHostBaseUrl = "http://127.0.0.1:8084/"; //for web
  static const String loginURL = "${localHostBaseUrl}auth/login";
  static const String profileURL = "${localHostBaseUrl}profile";
  static const String createProfileUrl = "${localHostBaseUrl}profile/matrimonialProfiles/";
  static const String getProfilesUrl = "${localHostBaseUrl}profile/matrimonialProfiles/";
  static const String getProfilesByUserIdUrl = "${localHostBaseUrl}profile/matrimonialProfiles/byuserId";
  static const String getProfileByIdUrl = "${localHostBaseUrl}profile/matrimonialProfiles";
  static const String updateProfileUrl = "${localHostBaseUrl}profile/matrimonialProfiles";



  static const String logoutUrl = "${baseUrl}Logout";
  static const String jobURL = "${baseUrl}DriverJob";
  static const String createUpdateUserUrl = "${baseUrl}UserManagement";
  static const String imageUploadUrl = "https://file.timesheetgt.com/api/FileUpload/Files";
}
