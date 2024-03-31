

class Product {
  String name;
  String description;
  int price;
  String image;
  String category;
  String id;
  int quantity = 1;
  int qty = 1
;
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.id,
    required this.quantity,
    required this.qty,
  });

void decreaseQuantity(){
  if(qty > 1){
    qty--;
  }
}

 void increaseQuantity(){
qty++;
}

}