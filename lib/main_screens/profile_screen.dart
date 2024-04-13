import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(
        title: 'Profile',
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children:[
          buildProfileImage(),
          const SizedBox(height: 30),
          buildSectionTitle(context, "Account Information"),
          buildInfoCard(context, "Name", "John Doe", Icons.person),
          buildInfoCard(context, "Email", "johndoe@example.com", Icons.email),
          buildInfoCard(context, "Address", "1234 Street, City, Country", Icons.location_on),
          buildInfoCard(context, "Phone Number", "+1234567890", Icons.phone),
          const SizedBox(height: 30),
          buildSectionTitle(context, "Settings"),
          buildSettingsItem(context, "Edit Profile", Icons.edit, () {}),
          buildSettingsItem(context, "Change Password", Icons.lock, () {}),
          buildSettingsItem(context, "Logout", Icons.exit_to_app, () {}),
        ],
      ),
    );
  }

  Widget buildProfileImage() {
    return Center(
      child: CircleAvatar(
        radius: 60,
        backgroundImage: const NetworkImage("https://via.placeholder.com/150"),
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }

  Widget buildInfoCard(BuildContext context, String label, String info, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(label, style: GoogleFonts.lato(fontSize: 12, color: Colors.grey)),
        subtitle: Text(info, style: GoogleFonts.lato(color: Colors.black), maxLines: 2, overflow: TextOverflow.ellipsis,),
      ),
    );
  }

  Widget buildSettingsItem(BuildContext context, String title, IconData icon, Function onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title, style: GoogleFonts.lato(fontSize: 16)),
      onTap: (){},
    );
  }
}
