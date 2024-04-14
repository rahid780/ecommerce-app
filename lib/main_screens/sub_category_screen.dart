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
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("SubCategory"),
      ),
    );
  }
}
