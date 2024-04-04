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
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
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
            color: Colors.white,
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: Image(
                image: NetworkImage(widget.productDetails['image']),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productDetails['name'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                            Text(
                              widget.productDetails['price'].toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ],
                        ),
                          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border, color: Colors.orange, size: 25,))
                      ],
                    ),
                  ),
                  Text(
                    widget.productDetails['description'],
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: Row(
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart, color: Colors.black, size: 25,)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.share, color: Colors.black, size: 25,)),
          Container(
            color: Colors.orange,
            child: TextButton(onPressed: (){}, child: const Text('Add to Cart', style: TextStyle(color: Colors.black,fontSize: 14),)))
        ],
      ),
    );
  }
}
