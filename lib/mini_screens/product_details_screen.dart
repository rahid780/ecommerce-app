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
        title: SizedBox(width: 200, child: Text(widget.productDetails['name'])),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: [
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
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.orange,
                        size: 25,
                      )),
                )
              ]),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.productDetails['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Rs. ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange),
                                          ),
                                          Text(
                                            (widget.productDetails['price'] / 3)
                                                .toStringAsFixed(0),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Rs. ${widget.productDetails['price']}',
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            (((widget.productDetails['price'] /
                                                            3) /
                                                        (widget.productDetails[
                                                            'price']) *
                                                        100) -
                                                    100)
                                                .toStringAsFixed(0),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          const Text(
                                            '%',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            '122 Sold',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: Colors.black,
                                                size: 15,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Item Description:',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              widget.productDetails['description'],
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              maxLines: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.store,
                color: Colors.red,
                size: 25,
              )),
          const SizedBox(
            height: 20,
            child: VerticalDivider(
              color: Colors.grey,
              width: 1,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chat,
                color: Colors.red,
                size: 25,
              )),
          Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Buy now',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ))),
          Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )))
        ],
      ),
    );
  }
}
