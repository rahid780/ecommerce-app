import 'package:firebase_provider/main_screens/categories_screen.dart';
import 'package:firebase_provider/main_screens/home_page.dart';
import 'package:flutter/material.dart';

class SubCategoryScreen extends StatelessWidget {
  final bool fromMain;
  const SubCategoryScreen({super.key, required this.fromMain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => fromMain == true
                        ? const HomePage()
                        : const CategoriesScreen()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("SubCategory"),
      ),
    );
  }
}
