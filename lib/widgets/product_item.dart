
import 'package:firebase_provider/providers/cart_provider.dart';
import 'package:firebase_provider/mini_screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ProductItem extends StatelessWidget {
  final dynamic productData;
  final bool? fromSearchScreen;

  const ProductItem({super.key, required this.productData,  this.fromSearchScreen});

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 80,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen( productDetails: productData,fromSearchScreen: fromSearchScreen,) ));
                },
                  child: Image(image: NetworkImage(productData['image'],), fit: BoxFit.cover,)
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                //const SizedBox(width: 8),
                context.watch<CartProvider>().cartList.any((element) => element.id == productData['id'])
                    ? badges.Badge(
                  badgeContent: const Icon(Icons.done_all, size: 10),
                  position: badges.BadgePosition.topStart(top: -5, start: 5), // Adjust the position of the badge
                  child: const Icon(Icons.add_shopping_cart, color: Colors.black, size: 20),
                )
                    : GestureDetector(
                    onTap: (){
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
                      child: const Icon(Icons.add_shopping_cart, size: 20)),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
