import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../models/cart_item.dart';
import '../../models/order_item.dart';
import '../../services/order_service.dart';

class OrdersManager with ChangeNotifier {
  List<OrderItem> _orders = [];

  final OrdersService _ordersService;

  OrdersManager([AuthToken? authToken])
      : _ordersService = OrdersService(authToken);

  set authToken(AuthToken? authToken) {
    _ordersService.authToken = authToken;
  }

  Future<void> fetchOrders([bool filterByUser = false]) async {
    _orders = await _ordersService.fetchOrders();
    print(_orders);
    notifyListeners();
  }

  Future<void> addOrder(OrderItem orderItem) async {
    final newProduct = await _ordersService.addOrder(orderItem);
    if (newProduct != null) {
      _orders.add(newProduct);
      notifyListeners();
    }
  }

  int get orderCount {
    return _orders.length;
  }

  //  List<OrderItem> get favoriteItems {
  //   return _items.where((prodItem) => prodItem.isFavorite).toList();
  // }

  List<OrderItem> get orders {
    return [..._orders];
  }

  OrderItem findById(String id) {
    return _orders.firstWhere((prod) => prod.id == id);
  }

  // void addOrder(List<CartItem> cartProducts, double total) async {
  //   _orders.insert(
  //       0,
  //       OrderItem(
  //         id: 'o${DateTime.now().toIso8601String()}',
  //         amount: total,
  //         products: cartProducts,
  //         dateTime: DateTime.now(),
  //       ));
  // }
}
