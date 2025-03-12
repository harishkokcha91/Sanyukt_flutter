import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/ProfileController.dart';
import '../Model/ProfileResponse.dart';
import '../Routing/Util/AppRoutes.dart';
import '../Utils/CustomNavigator.dart';
import '../Utils/GetDio.dart';

class ProfileListPage extends StatefulWidget {
  const ProfileListPage({super.key});

  @override
  _ProfileListPageState createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  List<Datum> profiles = [];
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
        profiles = response.data!;
        isLoading = false;
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
          ? Center(child: CircularProgressIndicator())
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
              onTap: () {
                CustomNavigator.pushTo(Routes.PROFILE_DETAILS, arguments: profile);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the new profile page
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => NewProfilePage()),
          // );
          CustomNavigator.pushTo(Routes.CREATE_PROFILE);
        },
        child: Icon(Icons.add),
        tooltip: "Add New Profile",
      ),
    );
  }
}
