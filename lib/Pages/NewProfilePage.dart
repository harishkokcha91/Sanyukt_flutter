import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/ProfileController.dart';
import '../Routing/Util/AppRoutes.dart';
import '../Utils/CustomNavigator.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({super.key});

  @override
  _NewProfilePageState createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  final ProfileController controller = Get.put(ProfileController());
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _currentLocationController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherOccupationController = TextEditingController();
  final TextEditingController _gotraGrandMotherController = TextEditingController();
  final TextEditingController _gotraMotherController = TextEditingController();
  final TextEditingController _gotraSelfController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherOccupationController = TextEditingController();
  final TextEditingController _phoneNumbersController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _siblingsController = TextEditingController();

  String? _selectedAnnualIncome;
  String? _selectedComplexion;
  String? _selectedMaritalStatus;
  String? _selectedOccupation;
  String? _selectedProfileFor;
  bool _manglik = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dateOfBirthController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_nameController, "Name"),
                _buildTextField(_addressController, "Address"),
                _buildDropdown("Annual Income", ["< 2 LPA", "2-5 LPA", "5-10 LPA", "10-20 LPA", "> 20 LPA"], (val) => setState(() => _selectedAnnualIncome = val)),
                _buildTextField(_birthPlaceController, "Birth Place"),
                _buildDropdown("Complexion", ["Fair", "Wheatish", "Dusky"], (val) => setState(() => _selectedComplexion = val)),
                _buildTextField(_currentLocationController, "Current Location"),
                _buildDatePicker("Date of Birth"),
                _buildTextField(_fatherNameController, "Father Name"),
                _buildTextField(_fatherOccupationController, "Father Occupation"),
                _buildTextField(_gotraGrandMotherController, "Gotra Grandmother"),
                _buildTextField(_gotraMotherController, "Gotra Mother"),
                _buildTextField(_gotraSelfController, "Gotra Self"),
                _buildTextField(_heightController, "Height"),
                _buildDropdown("Marital Status", ["Single", "Married", "Divorced"], (val) => setState(() => _selectedMaritalStatus = val)),
                _buildTextField(_motherNameController, "Mother Name"),
                _buildTextField(_motherOccupationController, "Mother Occupation"),
                _buildDropdown("Occupation", ["Private Job", "Government Job", "Business"], (val) => setState(() => _selectedOccupation = val)),
                _buildTextField(_phoneNumbersController, "Phone Number"),
                _buildDropdown("Profile For", ["Myself", "Son", "Daughter"], (val) => setState(() => _selectedProfileFor = val)),
                _buildTextField(_qualificationController, "Qualification"),
                _buildTextField(_siblingsController, "Siblings"),

                SwitchListTile(
                  title: const Text("Manglik"),
                  value: _manglik,
                  onChanged: (bool value) {
                    setState(() {
                      _manglik = value;
                    });
                  },
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final profileData = {
                        "name": _nameController.text,
                        "address": _addressController.text,
                        "annualIncome": _selectedAnnualIncome,
                        "birthPlace": _birthPlaceController.text,
                        "complexion": _selectedComplexion,
                        "currentLocation": _currentLocationController.text,
                        "dateOfBirth": _dateOfBirthController.text,
                        "fatherName": _fatherNameController.text,
                        "fatherOccupation": _fatherOccupationController.text,
                        "gotraGrandMother": _gotraGrandMotherController.text,
                        "gotraMother": _gotraMotherController.text,
                        "gotraSelf": _gotraSelfController.text,
                        "height": _heightController.text,
                        "manglik": _manglik,
                        "maritalStatus": _selectedMaritalStatus,
                        "motherName": _motherNameController.text,
                        "motherOccupation": _motherOccupationController.text,
                        "occupation": _selectedOccupation,
                        "phoneNumbers": _phoneNumbersController.text,
                        "profileFor": _selectedProfileFor,
                        "qualification": _qualificationController.text,
                        "siblings": _siblingsController.text,
                      };
                      print(profileData);
                      bool response = await controller.createProfile(profileData);
                      if (response) {
                        CustomNavigator.pushReplace(Routes.PROFILES);
                      }
                    }
                  },
                  child: const Text("Save Profile"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }

  Widget _buildDatePicker(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _dateOfBirthController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ),
      ),
    );
  }
}
