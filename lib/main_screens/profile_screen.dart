import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String name;
  late final String image;
  late final String email;
  late final String address;
  late final String phone;
  bool isLoading = true;

  void getUserData() {
    FirebaseFirestore.instance
        .collection('customers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        name = value['name'];
        image = value['profileImage'];
        email = value['email'];
        address = value['address'];
        phone = value['phone'];
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppBar(
          title: 'Profile',
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      buildProfileImage(image),
                      const SizedBox(height: 30),
                      buildSectionTitle(context, "Account Information"),
                      buildInfoCard(context, "Name", name, Icons.person),
                      buildInfoCard(context, "Email", email, Icons.email),
                      buildInfoCard(
                          context, "Address", address, Icons.location_on),
                      buildInfoCard(
                          context, "Phone Number", phone, Icons.phone),
                      const SizedBox(height: 30),
                      buildSectionTitle(context, "Settings"),
                      buildSettingsItem(
                          context, "Edit Profile", Icons.edit, () {}),
                      buildSettingsItem(
                          context, "Change Password", Icons.lock, () {}),
                      buildSettingsItem(
                          context, "Logout", Icons.exit_to_app, () {}),
                    ],
                  ),
                ),
              ));
  }

  Widget buildProfileImage(String url) {
    return Center(
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[200],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: FancyShimmerImage(
            imageUrl: url,
            boxFit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        title,
        style: GoogleFonts.lato(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }

  Widget buildInfoCard(
      BuildContext context, String label, String info, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(label,
            style: GoogleFonts.lato(fontSize: 12, color: Colors.grey)),
        subtitle: Text(info,
            style: GoogleFonts.lato(color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget buildSettingsItem(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: GoogleFonts.lato(fontSize: 16)),
      onTap: onTap,
    );
  }
}
