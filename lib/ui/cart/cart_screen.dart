import 'package:flutter/material.dart';
import 'package:fruitshop/models/auth_token.dart';
import 'package:fruitshop/models/order_item.dart';
import 'package:fruitshop/ui/auth/auth_manager.dart';
import 'package:fruitshop/ui/orders/orders_manager.dart';
import 'package:intl/intl.dart';
import '../../services/firebase_service.dart';
import 'cart_manager.dart';
import 'cart_item_card.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(44, 0, 0, 0),
      appBar: AppBar(
        title: const Text('Giỏ Hàng',
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Expanded(
            child: buildCartDetails(cart),
          ),
          buildCartSummary(cart, context)
        ],
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    if (cart.productCount == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Giỏ Hàng Trống!',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 92, 92, 92)),
          )
        ],
      );
    } else {
      return ListView(
        children: cart.productEntries
            .map(
              (entry) => CartItemCard(
                productId: entry.key,
                cartItem: entry.value,
              ),
            )
            .toList(),
      );
    }
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              height: height * 1 / 15,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Tổng tiền: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${NumberFormat.decimalPattern().format(cart.totalAmount)} Đồng',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: height * 1 / 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: (cart.productCount != 0)
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                            Color.fromARGB(218, 233, 140, 0),
                            Color.fromARGB(218, 209, 83, 10),
                          ])
                    : const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                            Color.fromARGB(218, 179, 179, 179),
                            Color.fromARGB(218, 61, 61, 61),
                          ])),
            child: TextButton(
              onPressed: cart.totalAmount <= 0
                  ? null
                  : () {
                      context.read<OrdersManager>().addOrder(
                            OrderItem(
                                amount: cart.totalAmount,
                                products: cart.products),
                          );
                      cart.clear();
                    },
              child: const Text('ĐẶT HÀNG',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
