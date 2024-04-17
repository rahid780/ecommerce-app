import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_provider/main_screens/sub_category_screen.dart';
import 'package:flutter/material.dart';


class CategoryItem extends StatelessWidget {
  final dynamic productData;
  const CategoryItem({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 120,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                productData['category'].toString().toUpperCase(),
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SubCategoryScreen(fromMain: true,)));
                },
                child: FancyShimmerImage(
                    imageUrl: productData['image'],
                    width: 90,
                    height: 90,
                    boxFit: BoxFit.cover,
                  ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
