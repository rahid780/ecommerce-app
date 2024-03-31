import 'package:firebase_provider/main_screens/home_page.dart';
import 'package:flutter/material.dart';


class ProductDetailsScreen extends StatefulWidget {
  final dynamic productDetails;
  const ProductDetailsScreen({super.key, required this.productDetails});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.productDetails['name']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(widget.productDetails['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            widget.productDetails['name'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,color: Colors.orange),),

              Text(
            widget.productDetails['price'].toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,color: Colors.orange),),

              Text(
            widget.productDetails['description'],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,color: Colors.orange),),
          
        ],
      ),
    );
  }
}