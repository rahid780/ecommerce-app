// ignore_for_file: prefer_const_constructors

import 'package:firebase_provider/providers/cart_provider.dart';
import 'package:firebase_provider/main_screens/home_page.dart';
import 'package:firebase_provider/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> proList = context.read<CartProvider>().cartList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Cart Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
      body: ListView(
        children: proList.map((e) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20),),
                    child: Image.network(e.image, width: 100,fit: BoxFit.cover,)),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.name, style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                        Text('PKR ${e.price.toString()}', style:const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                      ]),
                  ),
              
                    const SizedBox(width: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center ,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            context.read<CartProvider>().decreaseByOne(e);
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        e.qty.toString(),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            context.read<CartProvider>().increaseByOne(e);
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),



                  const SizedBox(width: 10),
                          IconButton(onPressed: (){
                            setState(() {
                              context.read<CartProvider>().removeItem(e);
                            });
                          }, icon: const Icon(Icons.delete),),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

