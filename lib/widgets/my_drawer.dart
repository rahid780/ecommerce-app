import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
    padding: EdgeInsets.zero,
    children: [
       DrawerHeader(
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.rectangle
          
        ),
        child: Image.asset('assets/images/img3.jpg', fit: BoxFit.cover,),
      ),
      ListTile(
        leading: const Icon(Icons.list),
        title: const Text('Orders'),
        onTap: () {
          // Navigate to orders screen
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
        onTap: () {
          // Navigate to settings screen
        },
      ),
      ListTile(
        leading: const Icon(Icons.notifications),
        title: const Text('Notifications'),
        onTap: () {
          // Navigate to notifications screen
        },
      ),
      ListTile(
        leading: const Icon(Icons.headset_mic),
        title: const Text('Support'),
        onTap: () {
          // Open support/contact screen
        },
      ),
      ListTile(
        leading: const Icon(Icons.feedback),
        title: const Text('Feedback'),
        onTap: () {
          // Open feedback screen
        },
      ),
      ListTile(
        leading: const Icon(Icons.info_outline),
        title: const Text('About Us'),
        onTap: () {
          // Navigate to about us screen
        },
      ),
      ListTile(
        leading: const Icon(Icons.policy),
        title: const Text('Privacy Policy'),
        onTap: () {
          // Open privacy policy link/screen
        },
      ),
      ListTile(
        leading: const Icon(Icons.exit_to_app),
        title: const Text('Logout'),
        onTap: () {
          // Handle user logout
        },
      ),
    ],
);

  }
}