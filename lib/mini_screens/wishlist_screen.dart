import 'package:collection/collection.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_provider/models/product_model.dart';
import 'package:firebase_provider/providers/cart_provider.dart';
import 'package:firebase_provider/providers/wish_provider.dart';
import 'package:firebase_provider/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Product> proList = context.read<WishProvider>().wishList;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(
        title: 'Wishlist',
        leadingIcon: const Icon(Icons.arrow_back),
        onLeadingIconPressed: () {
          Navigator.pop(context);
        },
      ),
      body: proList.isEmpty
          ? const Center(child: Text('Your Wishlist is Empty'))
          : ListView(
              children: proList.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 8.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size * 0.2,
                            height: size* 0.15,
                            child: FancyShimmerImage(
                              imageUrl: e.image,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: size * 0.67,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: size * 0.65,
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
                                        width: size * 0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            context
                                                        .read<CartProvider>()
                                                        .cartList
                                                        .firstWhereOrNull(
                                                            (product) =>
                                                                product.id ==
                                                                e.id) ==
                                                    null
                                                ? IconButton(
                                                    hoverColor:
                                                        Colors.grey[400],
                                                    onPressed: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                CartProvider>()
                                                            .addToCart(
                                                                e.name,
                                                                e.price,
                                                                e.image,
                                                                e.description,
                                                                e.id,
                                                                e.category,
                                                                e.quantity,
                                                                e.qty);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.shopping_cart,
                                                      size: 20,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : const Text('Already in Cart'),
                                            IconButton(
                                              hoverColor:
                                                  Colors.red.withOpacity(0.2),
                                              onPressed: () {
                                                setState(() {
                                                  context
                                                      .read<WishProvider>()
                                                      .removeWishItem(e);
                                                });
                                              },
                                              icon: const Icon(Icons.delete),
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
    );
  }
}
