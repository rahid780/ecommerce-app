// ignore_for_file: prefer_const_constructors

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_provider/providers/cart_provider.dart';
import 'package:firebase_provider/models/product_model.dart';
import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final bool? fromProductDetailsScreen;
  const CartScreen({super.key, this.fromProductDetailsScreen});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Product> proList = context.read<CartProvider>().cartList;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(
        title: 'Cart Screen',
        leadingIcon: widget.fromProductDetailsScreen == true
            ? Icon(Icons.arrow_back)
            : null,
        onLeadingIconPressed: () {
          Navigator.pop(context);
        },
      ),
      body: proList.isEmpty
          ? Center(child: const Text('Your cart is Empty'))
          : SizedBox(
              height: height * 0.72,
              child: ListView(
                children: proList.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 8.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size * 0.2,
                              height:size* 0.15,
                              child: FancyShimmerImage(
                                imageUrl: e.image,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: size * 0.67,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size * 0.5,
                                        height: size * 0.1,
                                        child: Text(
                                          e.name,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      IconButton(
                                        hoverColor: Colors.red.withOpacity(0.2),
                                        onPressed: () {
                                          setState(() {
                                            context
                                                .read<CartProvider>()
                                                .removeItem(e);
                                          });
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: size * 0.67,
                                    height: size * 0.09,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'PKR ${e.price.toString()}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: size * 0.3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                hoverColor: Colors.grey[400],
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all<
                                                              Color>(
                                                          Colors.grey.shade300),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    context
                                                        .read<CartProvider>()
                                                        .decreaseByOne(e);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.remove,
                                                  size: 20,
                                                ),
                                              ),
                                              Text(
                                                e.qty.toString(),
                                              ),
                                              IconButton(
                                                hoverColor: Colors.grey[400],
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all<
                                                              Color>(
                                                          Colors.grey.shade300),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    context
                                                        .read<CartProvider>()
                                                        .increaseByOne(e);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
      floatingActionButton: proList.isEmpty
          ? const SizedBox()
          : Container(
              width: size * 0.4,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Check Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
    );
  }
}
