import 'package:firebase_provider/cart_provider.dart';
import 'package:firebase_provider/mini_screens/cart_screen.dart';
import 'package:firebase_provider/mini_screens/category_home_widget.dart';
import 'package:firebase_provider/main_screens/electronics_screen.dart';
import 'package:firebase_provider/main_screens/fruits_screen.dart';
import 'package:firebase_provider/product_model.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Product> badgeLength = context.watch<CartProvider>().cartList;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          actions: [
            badges.Badge(
              badgeContent: Text(badgeLength.length.toString()),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
        body: const  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryWidget(category: 'Fruits', headline: 'Fresh and fast delivery', nextScreen: FruitsScreen(),),
              SizedBox(height: 10,),
              CategoryWidget(category: 'Electronics', headline: 'Original and branded', nextScreen: ElectronicsScreen(),),
            ],
          ),
        ));
  }
}
