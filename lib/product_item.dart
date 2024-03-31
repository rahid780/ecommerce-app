
import 'package:firebase_provider/cart_provider.dart';
import 'package:firebase_provider/mini_screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final dynamic productData;

  const ProductItem({super.key, required this.productData});

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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen( productDetails: productData,) ));
              },
                child: Image.network(
                  productData['image'],
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        productData['name'],
                        style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'PKR ${productData['price']}',
                      style: const TextStyle(color: Colors.orange, fontSize: 8, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                context.watch<CartProvider>().cartList.any((element) => element.id == productData['id'])
                    ? Image.asset('assets/icons/cart.png', width: 20, height: 20,): IconButton(
                        onPressed: () {
                          context.read<CartProvider>().addToCart(
                                productData['name'],
                                productData['price'],
                                productData['image'],
                                productData['description'],
                                productData['id'],
                                productData['category'],
                                productData['quantity'],
                                productData['qty'],
                              );
                        },
                        icon: const Icon(Icons.add_shopping_cart, size: 20,),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
