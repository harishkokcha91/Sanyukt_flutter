
class ApiEndPoints {
  static const String baseUrl = "https://app.timesheetgt.com/API.asmx/";
  static const String googleAPIKey = "AIzaSyCkRGFWU4lTsmqAqrCyzOwvWHVgxgMqH_0";

  static const String loginURL = "${baseUrl}Login";
  static const String logoutUrl = "${baseUrl}Logout";
  static const String jobURL = "${baseUrl}DriverJob";
  static const String createUpdateUserUrl = "${baseUrl}UserManagement";
  static const String imageUploadUrl = "https://file.timesheetgt.com/api/FileUpload/Files";
}
