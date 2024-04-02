
import 'package:firebase_provider/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{

 static List<Product> _cartList = [];

  List<Product> get cartList {
    return _cartList;
    }

    get getCartlistItemsList {
    return _cartList;
  }

  void addToCart(
    String name,
    int price,
    String image,
    String description,
    String id,
    String category,
    int quantity,
    int qty,
  ) {
    _cartList.add(
      Product(
        name: name,
        price: price,
        image: image,
        description: description,
        id: id,
        category: category,
        quantity: quantity,
        qty: qty,
      ),
    );
    notifyListeners();
  }

  void decreaseByOne(Product product){
    return product.decreaseQuantity();
  }

    void increaseByOne(Product product){
    return product.increaseQuantity();
  }


  void removeFromCart(String id) {
    _cartList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearCart() {
    _cartList.clear();
    notifyListeners();
  }



}