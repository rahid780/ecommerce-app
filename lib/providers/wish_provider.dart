import 'package:firebase_provider/models/product_model.dart';
import 'package:flutter/material.dart';

class WishProvider extends ChangeNotifier {
  static List<Product> _wishList = [];

  List<Product> get wishList {
    return _wishList;
  }

  get getWishListItemsList {
    return _wishList;
  }

  void addWishList(
    String name,
    int price,
    String image,
    String description,
    String id,
    String category,
    int quantity,
    int qty,
  ) {
    _wishList.add(
      Product(
        name: name,
        price: price,
        image: image,
        description: description,
        id: id,
        category: category,
        quantity: quantity,
        qty: qty)
        );
        notifyListeners();
  }

void removeWishItem( Product product){
  _wishList.remove(product);
  notifyListeners();
}

void removeFromWishList( String id){
  _wishList.removeWhere((element) => element.id == id);
  notifyListeners();
}

void clearWishList(){
  _wishList.clear();
  notifyListeners();
}



}
