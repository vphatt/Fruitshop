// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruitshop/models/cart_item.dart';
import 'package:fruitshop/models/order_item.dart';
import 'package:http/http.dart' as http;

import '../models/order_item.dart';
import '../models/auth_token.dart';

import 'firebase_service.dart';

class OrdersService extends FirebaseService {
  OrdersService([AuthToken? authToken]) : super(authToken);

  Future<List<OrderItem>> fetchOrders([bool filterByUser = false]) async {
    final List<OrderItem> orders = [];

    try {
      // final filters =
      //     filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final ordersUrl = Uri.parse(
          '$databaseUrl/orders.json?auth=$token&orderBy="creatorId"&equalTo="$userId"');
      final response = await http.get(ordersUrl);
      final ordersMap = json.decode(response.body) as Map<String, dynamic>;
      print(ordersUrl);
      ordersMap.forEach((id, order) {
        orders.add(
          OrderItem.fromJson({
            'id': id,
            ...order,
          }),
        );
      });
      print(orders);
      if (response.statusCode != 200) {
        print(ordersMap['error']);
        return orders;
      }

      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }

  Future<OrderItem?> addOrder(OrderItem orderItem) async {
    try {
      final url = Uri.parse('$databaseUrl/orders.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          orderItem.toJson()
            ..addAll({
              'creatorId': userId,
              'date': DateTime.now().toIso8601String(),
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      print(token);
      return orderItem.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Future<bool> updateProduct(Product product) async {
  //   try {
  //     final url =
  //         Uri.parse('$databaseUrl/products/${product.id}.json?auth=$token');
  //     final response = await http.patch(
  //       url,
  //       body: json.encode(product.toJson()),
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception(json.decode(response.body)['error']);
  //     }

  //     return true;
  //   } catch (error) {
  //     print(error);
  //     return false;
  //   }
  // }

  // Future<bool> deleteProduct(String id) async {
  //   try {
  //     final url = Uri.parse('$databaseUrl/products/$id.json?auth=$token');
  //     final response = await http.delete(url);

  //     if (response.statusCode != 200) {
  //       throw Exception(json.decode(response.body)['error']);
  //     }
  //     return true;
  //   } catch (error) {
  //     print(error);
  //     return false;
  //   }
  // }
}
