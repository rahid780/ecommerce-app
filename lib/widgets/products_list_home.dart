import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_provider/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsListHome extends StatelessWidget {
  const ProductsListHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All Products',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'Search for your needs and compforts',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  List<QueryDocumentSnapshot<Object?>>? data =
                      snapshot.data?.docs;

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ProductItem(
                        productData: data![index],
                        fromSearchScreen: true,
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
