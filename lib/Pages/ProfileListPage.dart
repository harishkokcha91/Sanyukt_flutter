import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/ProfileController.dart';
import '../Model/ProfileResponse.dart';
import '../Utils/GetDio.dart';

class ProfileListPage extends StatefulWidget {
  const ProfileListPage({super.key});

  @override
  _ProfileListPageState createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  List<Datum> profiles = []; // Store Datum objects
  bool isLoading = true;
  var dio = GetDio().getDio();
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    print("fetch Profile _ProfileListPageState");
    ProfileResponse? response = await controller.fetchProfiles(page: 1, limit: 10);
    if (response != null && response.data != null) {
      setState(() {
        profiles = response.data!; // Assign parsed data
        isLoading = false; // Update loading state
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profiles')),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader
          : profiles.isEmpty
          ? Center(child: Text("No profiles found."))
          : ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: profile.image != null && profile.image!.isNotEmpty
                    ? NetworkImage(profile.image!)
                    : AssetImage('assets/default_profile.png') as ImageProvider,
              ),
              title: Text(profile.name ?? 'Unknown'),
              subtitle: Text("${profile.qualification ?? 'N/A'} - ${profile.occupation ?? 'N/A'}"),
              trailing: Text(profile.maritalStatus?.toUpperCase() ?? 'UNKNOWN'),
            ),
          );
        },
      ),
    );
  }
}
