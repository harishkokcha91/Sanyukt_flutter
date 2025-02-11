import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timesheetgt/Constants/Constants.dart';
import 'package:timesheetgt/Controller/DriverController.dart';
import 'package:timesheetgt/Routing/Util/AppRoutes.dart';
import 'package:timesheetgt/Routing/Util/Loader.dart';
import 'package:timesheetgt/Utils/CustomNavigator.dart';
import 'package:timesheetgt/Utils/PreferenceManager.dart';
import 'package:timesheetgt/Utils/Spacers.dart';
import 'package:timesheetgt/Widgets/DropDownSecondary.dart';
import 'package:timesheetgt/Widgets/ParentWidgetMobile.dart';
import 'package:timesheetgt/Widgets/PrimaryButton.dart';
import 'package:get/get.dart';
import 'package:timesheetgt/Widgets/TextFieldPrimary.dart';
import 'package:google_geocoding/google_geocoding.dart' as gCoding;
import 'package:location/location.dart' as locationLib;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:file_picker/file_picker.dart';
import '../Constants/ApiEndPoints.dart';
import '../Model/SelectedFileModel.dart';
import '../Networking/DriverApi.dart';
import '../Utils/Permissions.dart';
import '../Utils/ShowMessages.dart';
import '../Widgets/BorderButton.dart';
import 'package:image_picker/image_picker.dart';


class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {

  var googleGeocoding = gCoding.GoogleGeocoding(ApiEndPoints.googleAPIKey);
  gCoding.GeocodingResult? selectedAddressOnMap ;
  Rxn<LatLng> newCoordinates =  Rxn<LatLng>();
  RxString stMyLocation = "".obs;
  late double selAddLat;
  late double selAddLong;
  DriverController driverController = Get.put(DriverController());
  final TextEditingController siteNameController = TextEditingController();
  final TextEditingController ticketNumberController = TextEditingController();
  final TextEditingController childTicketController = TextEditingController();
  final TextEditingController faCodeController = TextEditingController();
  final TextEditingController gallonInGeneratorController = TextEditingController();
  final TextEditingController generatorHrContoller = TextEditingController();
  final TextEditingController generatorMinContoller = TextEditingController();
  final TextEditingController matsIdContoller = TextEditingController();
  final TextEditingController gallonInTruckController = TextEditingController();
  final TextEditingController pricePerGallonController = TextEditingController();
  final TextEditingController pricePerGallonGeneratorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<File> _selectedImage = [];
  final ImagePicker _picker = ImagePicker();
  final String uploadUrl = "https://file.timesheetgt.com/api/FileUpload/Files";

  int count = 1;

  getCurrentLocationMobile() async {
    geolocator.Position currLoc = await getUserCurrentLocation();
    selAddLat = currLoc.latitude;
    selAddLong = currLoc.longitude;

    newCoordinates.value = LatLng(selAddLat, selAddLong);
  }
  static getUserCurrentLocation() async {
    geolocator.Position currentLocation = await locateUser();
    return currentLocation;
  }

  static Future<geolocator.Position> locateUser() async {

    LocationPermission permission = await Geolocator.requestPermission();

    var status = await Permission.location.status;
    print("Location permission $status");
    if (status.isDenied || !status.isGranted) {
      Permission.location.request();
    }

    bool isPermissionGiven = await Permissions.locationPermissionsGranted();
    if (await Permissions.locationPermissionsGranted()) {
      try {
        return await Geolocator.getCurrentPosition();
      } catch (e) {
        ShowMessages().showSnackBarRed('Warning!', 'We need your permission to serve you better.');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  getUserLocation() async{
    locationLib.Location location = new locationLib.Location();
    locationLib.LocationData locationData = await location.getLocation();
    print("Location data ${locationData.latitude} ${locationData.longitude}");
    newCoordinates.value = LatLng(locationData.latitude!, locationData.longitude!);
    selAddLat = locationData.latitude!;
    selAddLong = locationData.longitude!;
  }

  pickFile() async {
    if (!kIsWeb) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
            withReadStream: true
        );
        if (result != null) {
          PlatformFile file = result.files.first;
          print("Picked file extension ${file.extension}");
          var bytes = await streamToUint8List(file.readStream!);
          if (file.extension.toString() == "pdf" || file.extension.toString() == "doc" || file.extension.toString() == "docx"){
            driverController.selectedFilesToUploadMob.add(SelectedFileModel(fileData: bytes, fileName: file.name));
            setState(() {});
          }else if (file.extension.toString() == "jpg" || file.extension.toString() == "jpeg" || file.extension.toString() == "png"){
            driverController.selectedFilesToUploadMob.add(SelectedFileModel(fileData: bytes, fileName: file.name));
            setState(() {});
          }else{
            ShowMessages().showSnackBarRed('', 'File type not supported');
          }

        } else {
          // ShowMessages().showSnackBarRed("File Not Selected", "");
        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        );
        if (result != null) {
          PlatformFile file = result.files.first;
          driverController.selectedFilesToUploadMob.add(
              SelectedFileModel(fileData: file.bytes!, fileName: file.name));
          setState(() {});
        } else {
          // ShowMessages().showSnackBarRed("File Not Selected", "");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<Uint8List> streamToUint8List(Stream<List<int>> stream) async {
    // Collect all bytes from the stream
    List<int> bytes = await stream.fold<List<int>>(
      <int>[],
          (List<int> previous, List<int> chunk) => previous..addAll(chunk),
    );

    // Create a Uint8List from the collected bytes
    return Uint8List.fromList(bytes);
  }

  clearImage(index) {
    setState(() {
      _selectedImage.removeAt(index);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage.add(File(pickedFile.path));
      });
    }
  }


  askForDeleteUser() {
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Delete Account?",
              style: Get.theme.textTheme.displaySmall
                  ?.copyWith(
                  fontWeight: FontWeight.w400),
            ),
            CustomSpacers.height16,
            Text(
              "All your data and reports will be lost if you proceed.",
              style: Get.theme.textTheme.titleMedium
                  ?.copyWith(
                  fontWeight: FontWeight.w400),
            ),
            CustomSpacers.height16,
            Obx(() {
              return (driverController.isUpdateLoading.value)?Loader():Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BorderButton(
                    onTap: (){
                      Get.back();
                    },
                    buttonText: "No",
                    hasPrimaryOnRight: true,
                  ),

                  PrimaryButton(
                    onTap: () async{
                      driverController.isUpdateLoading.value = true;
                      var jsonParam = {
                        "userid": int.parse(PreferenceManager().getUserId()),
                        "usrname": "",
                        "usertype": 1,
                        "password": "",
                        "address": "",
                        "bank_acc_details": "",
                        "mobileno": "",
                        "created_by": int.parse(PreferenceManager().getUserId()),
                        "usertime": "${DateTime.now().toIso8601String()}Z",
                        "status_id": 2,
                        "spmode": 1
                      };
                      await driverController.deleteUser(jsonParam: jsonParam);
                      driverController.isUpdateLoading.value = false;
                      CustomNavigator.pushTo(Routes.LOGOUT);
                    },
                    buttonText: "Proceed",
                  )
                ],
              );
            }
            ),

          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
       if(PreferenceManager().getDriverJobId() != 0){
         driverController.hasJobStarted.value = true;
       }else{
         driverController.hasJobStarted.value = false;
       }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidgetMobile(
      layout: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16),
          child: Obx(() {
              return (!driverController.hasJobStarted.value)?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                          return (driverController.isLoading.value)?Loader():
                          PrimaryButton(
                              onTap: () async{
                                driverController.isLoading.value = true;
                                if(kIsWeb) {
                                  await getUserLocation();
                                }else{
                                  await getCurrentLocationMobile();
                                }
                                var jsonParam = {
                                  "driver_job_id": 0,
                                  "site_name":"",
                                  "req_frm":0,
                                  "ticket_number": 0,
                                  "child_ticket": 0,
                                  "fa_code": 0,
                                  "ticket_type": "",
                                  "gallons": 0,
                                  "generator_hr": 0,
                                  "generator_min": 0,
                                  "mats_id": 0,
                                  "closed_or_updated": "",
                                  "gallons_in_truck": 0,
                                  "price_per_gal_for_truck": 0,
                                  "price_per_gal_for_generator": 0,
                                  "status_id": 0,
                                  "job_user_start_time": "${DateTime.now().toIso8601String()}Z",
                                  "job_user_end_time": "${DateTime.now().toIso8601String()}Z",
                                  "job_end_longitude": "$selAddLong",
                                  "job_end_latitude": "$selAddLat",
                                  "job_start_location": "",
                                  "job_end_location": "",
                                  "job_start_latitude": "$selAddLat",
                                  "job_start_longitude": "$selAddLong",
                                  "job_start_ip_address": "",
                                  "job_end_ip_address": "",
                                  "created_by": int.parse(PreferenceManager().getUserId()),
                                  "description": "",
                                  "documents": "",
                                  "user_time": "${DateTime.now().toIso8601String()}Z",
                                  "spmode": 0
                                };
                                print("jsonParam>>>> $jsonParam");
                                await driverController.driverJob(jsonParam: jsonParam,isJobStarted: true);
                                clearControllers();
                                driverController.isLoading.value = false;
                              },
                              buttonText: "Start Job"
                          );
                        }
                      ),
                    ],
                  )
                ],
              ):
              (driverController.isLoading.value)?Loader()
                  :ListView(
                shrinkWrap: true,
                children: [
                  CustomSpacers.height24,
                  TextFieldPrimary(
                    controller: siteNameController,
                    hint: "Site Name",
                    isLabelNeeded: true,
                    isMandatory: true,
                    keyboardType: TextInputType.text,
                    label: "Site Name",
                  ),
                  CustomSpacers.height16,
                  TextFieldPrimary(
                      controller: ticketNumberController,
                      hint: "Ticket Number(eg. M1234)",
                    isLabelNeeded: true,
                    isMandatory: true,
                    maxLetterLength: 10,
                    keyboardType: TextInputType.text,
                    label: "Ticket Number",
                  ),
                  CustomSpacers.height16,
                  TextFieldPrimary(
                    controller: childTicketController,
                    hint: "Child(Refuel) Ticket(eg. M1234)",
                    isLabelNeeded: true,
                    isMandatory: false,
                    maxLetterLength: 10,
                    keyboardType: TextInputType.text,
                    label: "Child(Refuel) Ticket",
                  ),
                  CustomSpacers.height16,
                  TextFieldPrimary(
                    controller: faCodeController,
                    hint: "FA Code",
                    isLabelNeeded: true,
                    isMandatory: true,
                    maxLetterLength: 8,
                    arrTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]')),
                    ],
                    keyboardType: TextInputType.number,
                    label: "FA Code",
                  ),
                  CustomSpacers.height16,
                  DropDownSecondary(
                      value: driverController.selTicketType.value,
                      typeList: driverController.ticketType,
                      title: "Ticket Type",
                      mandatory: true,
                      borderColor: Colors.grey.shade400,
                      onChanged: (v){
                        driverController.selTicketType.value = v;
                      }
                  ),
                  CustomSpacers.height16,
                  TextFieldPrimary(
                    controller: gallonInGeneratorController,
                    hint: "Gallons in generator",
                    isLabelNeeded: true,
                    isMandatory: true,
                    arrTextInputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                      DecimalTextInputFormatter(decimalRange: 3),
                    ],
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    label: "Gallons (in Generators)",
                  ),
                  CustomSpacers.height16,
                  TextFieldPrimary(
                    controller: pricePerGallonGeneratorController,
                    hint: "Price per Gallon \$ (in generator)",
                    isLabelNeeded: true,
                    isMandatory: true,
                    arrTextInputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                      DecimalTextInputFormatter(decimalRange: 3),
                    ],
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    label: "Gallon Price \$ (in generator)",
                  ),
                  CustomSpacers.height16,
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldPrimary(
                          controller: generatorHrContoller,
                          hint: "Generator Hours",
                          isLabelNeeded: true,
                          isMandatory: true,
                          keyboardType: TextInputType.number,
                          label: "Generator Hours",
                          onChanged: (val){
                          },
                          arrTextInputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                        ),
                      ),
                      hSpacer(8),
                      Expanded(
                        child: TextFieldPrimary(
                          controller: generatorMinContoller,
                          hint: "Generator Mins",
                          isLabelNeeded: true,
                          keyboardType: TextInputType.number,
                          maxLetterLength: 2,
                          arrTextInputFormatter: [
                            FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]')),
                            ],
                          label: "Generator Mins",
                          onChanged: (val){
                            if(int.parse(val) > 60){
                              generatorMinContoller.text = "";
                              ShowMessages().showSnackBarRed("Please enter correct minutes", "Minutes can not be greater than 60.");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  CustomSpacers.height16,
                  TextFieldPrimary(
                    controller: matsIdContoller,
                    hint: "MATS Id",
                    isLabelNeeded: true,
                    isMandatory: true,
                    maxLetterLength: 6,
                    arrTextInputFormatter: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]')),
                    ],
                    keyboardType: TextInputType.number,
                    label: "MATS Id",
                  ),
                  CustomSpacers.height16,
                  DropDownSecondary(
                      value: driverController.selCloseOrUpdated.value,
                      typeList: driverController.closeUpdated,
                      title: "Close or Updated",
                      mandatory: false,
                      borderColor: Colors.grey.shade400,
                      onChanged: (v){
                        driverController.selCloseOrUpdated.value = v;
                      }
                  ),
                  CustomSpacers.height16,
                  TextFieldPrimary(
                    controller: gallonInTruckController,
                    hint: "Gallons in trucks",
                    isLabelNeeded: true,
                    isMandatory: true,
                    arrTextInputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                      DecimalTextInputFormatter(decimalRange: 3),
                    ],
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    label: "Gallons (in trucks)",
                  ),
                  CustomSpacers.height16,

                  TextFieldPrimary(
                    controller: pricePerGallonController,
                    hint: "Price per Gallon \$ (in trucks)",
                    isLabelNeeded: true,
                    isMandatory: true,
                    arrTextInputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                      DecimalTextInputFormatter(decimalRange: 3),
                    ],
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    label: "Gallon Price \$ (in trucks)",
                  ),
                  CustomSpacers.height16,

                  TextFieldPrimary(
                    controller: descriptionController,
                    hint: "Description",
                    maxLines: 5,
                    isLabelNeeded: true,
                    isMandatory: false,
                    keyboardType: TextInputType.text,
                    label: "Description",
                  ),
                  CustomSpacers.height24,
                  (_selectedImage.isNotEmpty)?
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _selectedImage.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: Image.file(
                                _selectedImage[index],
                                height: 88,
                                width: Get.width,
                              ),
                            ),
                            hSpacer(8),
                            InkWell(
                              onTap: (){
                                clearImage(index);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      );
                    },
                  ):
                  const SizedBox.shrink(),
                  CustomSpacers.height12,
                  InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.bottomSheet(Container(
                        height: 170,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)
                            )
                        ),
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  Expanded(
                                    child: Text(
                              (_selectedImage.length>1)?"Upload Next File":"Upload File",
                                      style: Get.textTheme.titleMedium!.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                      onTap: (){
                                        Get.back();
                                      },
                                      child: const Icon(Icons.close, ))
                                ],
                              ),
                            ),

                            const Divider(),

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        Get.back();
                                        _pickImage(ImageSource.gallery);
                                      },
                                      child: Column(
                                        children: [
                                          const Icon(Icons.file_copy_outlined, color: Constants.COLOR_PRIMARY, size: 32,),

                                          Text("Select From Device",
                                            textAlign: TextAlign.center,
                                            style: Get.textTheme.titleMedium!.copyWith(
                                                fontSize: 14,
                                                color: Constants.COLOR_PRIMARY
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        Get.back();
                                        _pickImage(ImageSource.camera);
                                        // Get.to(CameraCapturePage())
                                      },
                                      child: Column(
                                        children: [
                                          const Icon(Icons.camera_alt_outlined, color: Constants.COLOR_PRIMARY, size: 32,),

                                          Text("Capture and Upload",
                                            textAlign: TextAlign.center,
                                            style: Get.textTheme.titleMedium!.copyWith(
                                                fontSize: 14,
                                                color: Constants.COLOR_PRIMARY
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
                      // pickFile();
                    },
                    child: Container(
                      height: 92,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          color: Constants
                              .COLOR_BACKGROUND),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.file_upload_outlined,
                            color: Constants.COLOR_PRIMARY,
                            size: 18,
                          ),
                          responsiveWidthSpacer(10),
                          Text(
                            "Upload File",
                            style: Get.theme.textTheme.titleSmall!
                                .copyWith(
                                fontWeight: FontWeight.w400,
                                color: Constants
                                    .COLOR_PRIMARY),
                          ),
                        ],
                      ),
                    ),
                  ),

                  CustomSpacers.height24,
                  PrimaryButton(
                    onTap: () async{
                      driverController.isLoading.value = true;
                      for(int i=0;i<_selectedImage.length;i++){
                        await DriverApi().uploadImage(
                            selectedImage: _selectedImage[i],
                            driverId: int.parse(PreferenceManager().getUserId()),
                            driverJobId: driverController.driverStartJobDataModel.value!.data!.data![0].driverJobId
                        );
                      }

                      if(kIsWeb) {
                        await getUserLocation();
                      }else{
                        await getCurrentLocationMobile();
                      }
                      var jsonParam = {
                        "driver_job_id": PreferenceManager().getDriverJobId(),
                        "site_name":siteNameController.text.trim().toString(),
                        "req_frm":0,
                        "ticket_number": ticketNumberController.text.trim().toString(),
                        "child_ticket": childTicketController.text.trim().toString(),
                        "fa_code": faCodeController.text.trim().toString(),
                        "ticket_type": driverController.selTicketType.value,
                        "gallons": gallonInGeneratorController.text.trim().toString(),
                        "generator_hr": generatorHrContoller.text.trim().toString(),
                        "generator_min": generatorMinContoller.text.trim().toString(),
                        "mats_id": matsIdContoller.text.trim().toString(),
                        "closed_or_updated": (driverController.selCloseOrUpdated.value == "Select")?"":driverController.selCloseOrUpdated.value,
                        "gallons_in_truck": gallonInTruckController.text.trim().toString(),
                        "price_per_gal_for_truck": pricePerGallonController.text.trim().toString(),
                        "price_per_gal_for_generator": pricePerGallonGeneratorController.text.trim().toString(),
                        "status_id": 0,
                        "job_user_end_time": "${DateTime.now().toIso8601String()}Z",
                        "job_user_start_time": "${DateTime.now().toIso8601String()}Z",
                        "job_start_longitude": "",
                        "job_start_latitude": "",
                        "job_start_location": "",
                        "job_end_location": "",
                        "job_end_longitude": "$selAddLong",
                        "job_end_latitude": "$selAddLat",
                        "job_start_ip_address": "",
                        "job_end_ip_address": "",
                        "description": descriptionController.text.trim().toString(),
                        "created_by": int.parse(PreferenceManager().getUserId()),
                        "user_time": "${DateTime.now().toIso8601String()}Z",
                        "documents": "",
                        "spmode": 0
                      };
                      print("jsonParam>>>> $jsonParam");
                      await driverController.driverJob(jsonParam: jsonParam,isJobStarted: false);
                      driverController.isLoading.value = false;
                    },
                    buttonText: "Submit Job",
                  ),
                  CustomSpacers.height24,


                ],
              );
            }
          ),
        ),
      ),
      widget1: PopupMenuButton<String>(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
        offset: const Offset(0, kToolbarHeight-24),
        constraints: BoxConstraints(),
        onSelected: (value)  async{
          if(value == "Logout"){
            CustomNavigator.pushTo(Routes.LOGOUT);
          }else if(value == "Delete Account"){
            askForDeleteUser();
          }
        },
        itemBuilder: (BuildContext context) {
          return {"Logout","Delete Account"}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              height: 18,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    if(choice == "Logout")...[
                      const Icon(
                        Icons.logout,
                        color: Constants.COLOR_PRIMARY,
                        size: 24,
                      )],
                    if(choice == "Delete Account")...[
                      const Icon(
                        Icons.delete,
                        color: Constants.COLOR_PRIMARY,
                        size: 24,
                      )],

                    const SizedBox(width: 6),
                    Text(
                      choice,
                      style: Get.theme.textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList();
        },
      ),

      // InkWell(
      //   onTap: (){
      //     CustomNavigator.pushReplace(Routes.LOGOUT);
      //   },
      //   child: const Icon(
      //     Icons.logout,
      //     color: Colors.white,
      //     size: 24,
      //   ),
      // ),
      showBackButton: false,
      title: "Hi, ${PreferenceManager().getUserName()}",
    );
  }

  void clearControllers() {
    siteNameController.text = "";
     ticketNumberController.text = "";
    childTicketController.text = "";
    faCodeController.text = "";
    gallonInGeneratorController.text = "";
    generatorHrContoller.text = "";
     generatorMinContoller.text = "";
     matsIdContoller.text = "";
     gallonInTruckController.text = "";
     pricePerGallonController.text = "";
     pricePerGallonGeneratorController.text = "";
     descriptionController.text = "";
     _selectedImage.clear();
     driverController.selTicketType.value = 'Deploy';
    driverController.selCloseOrUpdated.value = 'Select';
    }
}


class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;

  DecimalTextInputFormatter({this.decimalRange = 3});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.isEmpty) {
      return newValue;
    }

    // Regex to allow only numbers with up to `decimalRange` decimal places
    final regex = RegExp(r'^\d+(\.\d{0,3})?$');

    if (regex.hasMatch(text)) {
      return newValue;
    } else {
      return oldValue; // Reject invalid input without resetting
    }
  }
}
