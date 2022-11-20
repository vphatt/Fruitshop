// ignore_for_file: prefer_final_fields

import '../../models/cart_item.dart';
import '../../models/product.dart';

import 'package:flutter/foundation.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _items = {};

  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  existProduct(Product product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      //change quantity
      _items.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
          product.id!,
          () => CartItem(
              id: 'c${DateTime.now().toIso8601String()}',
              title: product.title,
              price: product.price,
              quantity: 1,
              imageUrl: product.imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as num > 1) {
      _items.update(
          productId,
          (existingCartItem) => existingCartItem.copyWith(
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  checkQuantity(String productId) {
    if (_items[productId]?.quantity as num == 1) {
      return true;
    }
  }

  void addSingleItem(String productId) {
    _items.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
              quantity: existingCartItem.quantity + 1,
            ));

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
