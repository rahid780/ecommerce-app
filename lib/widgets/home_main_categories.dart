import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_provider/widgets/category_item.dart';
import 'package:flutter/material.dart';

class MainCategories extends StatefulWidget {
  final Widget nextScreen;
  final String category;
  final String headline;

  const MainCategories(
      {super.key,
      required this.nextScreen,
      required this.category,
      required this.headline});

  @override
  State<MainCategories> createState() => _MainCategoriesState();
}

class _MainCategoriesState extends State<MainCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      widget.headline,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => widget.nextScreen));
                        },
                        child: const Text(
                          'See more >',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                Map<String, Map<String, dynamic>> productDetailsByCategory = {};

                snapshot.data!.docs.forEach((document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String category = data['category'];

                  if (!productDetailsByCategory.containsKey(category)) {
                    productDetailsByCategory[category] = data;
                  }
                });

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
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
          ),
        ],
      ),
    );
  }
}
