import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItemToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cartItems[index].quantity = (_cartItems[index].quantity ?? 0) + 1;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    int currentQuantity = _cartItems[index].quantity ?? 0;
    // Decrement the quantity by 1 if it's greater than 0
    if (currentQuantity > 0) {
      _cartItems[index].quantity = currentQuantity - 1;
      // If the quantity becomes 0, remove the item from the cart
      if (_cartItems[index].quantity == 0) {
        removeItemFromCart(index);
      }
      // Notify listeners to update the UI
      notifyListeners();
    }
  }

  double getTotalPrice() {
  double totalPrice = 0;
  for (var item in _cartItems) {
    totalPrice += (item.price ?? 0) * (item.quantity ?? 0);
  }
  return totalPrice;
}

}

class CartItem {
  int? quantity;
  int? id;
  int? catid;
  String? productname;
  double? price;
  String? imageUrl;

  CartItem({
    this.id,
    this.catid,
    this.productname,
    this.price,
    this.imageUrl,
    this.quantity = 1, // Set default quantity to 1
  });

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'id': id,
      'catid': catid,
      'productname': productname,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
