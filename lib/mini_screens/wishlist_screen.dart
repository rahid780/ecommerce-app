import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Wishlist Screen',
        leadingIcon: const Icon(Icons.arrow_back),
        onLeadingIconPressed: () {
          Navigator.pop(context);
        },
      ),
      body: const Center(
        child: Text('Wishlist Screen'),
      ),
    );
  }
}
