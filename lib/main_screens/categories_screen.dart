import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
          title: 'Categories',
        ),
      body: Center(
        child: Text('Categories'),
      ),
    );
  }
}