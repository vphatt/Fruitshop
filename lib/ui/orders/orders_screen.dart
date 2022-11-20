// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fruitshop/models/order_item.dart';
import 'package:provider/provider.dart';

import 'orders_manager.dart';
import 'order_item_card.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});
  // final OrderItem orderItem;

  Future<void> _refreshOrders(BuildContext context) async {
    await context.read<OrdersManager>().fetchOrders(true);
  }

  @override
  Widget build(BuildContext context) {
    print('building orders');

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'Lịch sử đặt hàng',
            style: TextStyle(color: Colors.black),
          ),
        ),
        // body: FutureBuilder(
        //   future: _refreshOrders(context),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     return RefreshIndicator(
        //       onRefresh: () => _refreshOrders(context),
        //       child: Consumer<OrdersManager>(
        //         builder: (ctx, ordersManager, child) {
        //           return ListView.builder(
        //               itemCount: ordersManager.orderCount,
        //               itemBuilder: (ctx, i) =>
        //                   OrderItemCard(ordersManager.orders[i]));
        //         },
        //       ),
        //     );
        //   },
        // ),
        body: Consumer<OrdersManager>(
          builder: (ctx, ordersManager, child) {
            return ListView.builder(
                itemCount: ordersManager.orderCount,
                itemBuilder: (ctx, i) =>
                    OrderItemCard(ordersManager.orders[i]));
          },
        ));
  }
}
