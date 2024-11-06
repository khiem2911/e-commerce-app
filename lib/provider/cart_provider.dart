import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final List<Item> _cartItems = [];
  double _totalCart = 0;

  List<Item>? get cartItems => _cartItems;
  double get totalCart => _totalCart;

  Map<String, dynamic> toMap(Item item) {
    return {'image': item.image, 'title': item.name, 'price': item.price};
  }

  Future<void> onCheckOut() async {
    List<Map<String, dynamic>> temptCart =
        _cartItems.map((item) => toMap(item)).toList();

    _cartItems.clear();

    for (var i in temptCart) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('carts')
          .add(i);
    }

    notifyListeners();
  }

  bool onToogleItemToCart(Item item) {
    bool checked = _cartItems.contains(item);

    if (checked == false) {
      _cartItems.add(item);
      onTotalCart(item, null);
      return false;
    }
    return true;
  }

  void onRemoveItem(Item item) {
    _cartItems.remove(item);
    onTotalCart(item, null);
  }

  void onTotalCart(Item item, bool? checked) {
    if (checked == true) {
      item.quantity += 1;
    } else if (checked == false) {
      item.quantity -= 1;
    } else {
      item.quantity = 1;
    }

    if (item.quantity == 0) {
      _cartItems.remove(item);
    }

    final index = _cartItems.indexWhere((value) => value.name == item.name);

    if (index >= 0) {
      _cartItems[index].quantity = item.quantity;
    }

    List<double> result =
        _cartItems.map((data) => data.price * data.quantity).toList();
    if (result.isNotEmpty) {
      final total = result.reduce((value, element) => value + element);
      _totalCart = total;
    } else {
      _totalCart = 0;
    }
    notifyListeners();
  }
}
