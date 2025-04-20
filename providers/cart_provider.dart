import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;
  void addToCart(Map<String, dynamic> item) {
    final newItem = {
      'name': item['name'],
      'price': item['price'] ?? 0.0,
      'imageUrl': item['imageUrl'],
      'quantity': 1,
      'totalPrice': (item['price'] ?? 0.0),
    };
    _cartItems.add(newItem);
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _cartItems[index]['quantity'] =
        (_cartItems[index]['quantity'] ?? 1) + 1;
    _cartItems[index]['totalPrice'] =
        (_cartItems[index]['price'] ?? 0.0) * (_cartItems[index]['quantity'] ?? 1);
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if ((_cartItems[index]['quantity'] ?? 1) > 1) {
      _cartItems[index]['quantity'] =
          (_cartItems[index]['quantity'] ?? 1) - 1;
      _cartItems[index]['totalPrice'] =
          (_cartItems[index]['price'] ?? 0.0) * (_cartItems[index]['quantity'] ?? 1);
    } else {
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }
  double get totalAmount {
    double total = 0.0;
    for (var item in _cartItems) {
      total += (item['totalPrice'] ?? 0.0);
    }
    return total;
  }

  void removeFromCart(Map<String, dynamic> item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void clearCart() {}
}
