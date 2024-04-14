import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_provider/main_screens/home_page.dart';
import 'package:firebase_provider/widgets/category_item.dart';
import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final bool fromHome;
  const CategoriesScreen({
    super.key, required this.fromHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Categories',
        leadingIcon: fromHome == true ? null : const Icon(Icons.arrow_back),
        onLeadingIconPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          Map<String, Map<String, dynamic>> productDetailsByCategory = {};

          snapshot.data!.docs.forEach((document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String category = data['category'];

            if (!productDetailsByCategory.containsKey(category)) {
              productDetailsByCategory[category] = data;
            }
          });

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              scrollDirection: Axis.vertical,
              itemCount: productDetailsByCategory.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    productDetailsByCategory.values.toList()[index];
                return CategoryItem(productData: data);
              },
            ),
          );
        },
      ),
    );
  }
}
