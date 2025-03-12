import 'package:flutter/material.dart';
import '../Model/ProfileResponse.dart';

class ProfileDetailPage extends StatelessWidget {
  final Datum profile;

  ProfileDetailPage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(profile.name ?? 'Profile Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: profile.image != null && profile.image!.isNotEmpty
                      ? NetworkImage(profile.image!)
                      : AssetImage('assets/default_profile.png') as ImageProvider,
                ),
              ),
              SizedBox(height: 20),
              _buildDetailRow("Name", profile.name),
              _buildDetailRow("Qualification", profile.qualification),
              _buildDetailRow("Occupation", profile.occupation),
              _buildDetailRow("Marital Status", profile.maritalStatus),
              _buildDetailRow("Date of Birth", profile.dateOfBirth?.toString()),
              _buildDetailRow("Address", profile.address),
              _buildDetailRow("Phone Number", profile.phoneNumbers),
              _buildDetailRow("Annual Income", profile.annualIncome),
              _buildDetailRow("Height", profile.height),
              _buildDetailRow("Father's Name", profile.fatherName),
              _buildDetailRow("Father's Occupation", profile.fatherOccupation),
              _buildDetailRow("Mother's Name", profile.motherName),
              _buildDetailRow("Mother's Occupation", profile.motherOccupation),
              _buildDetailRow("Gotra (Self)", profile.gotraSelf),
              _buildDetailRow("Gotra (Mother)", profile.gotraMother),
              _buildDetailRow("Gotra (Grandmother)", profile.gotraGrandMother),
              _buildDetailRow("Siblings", profile.siblings),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }
}
