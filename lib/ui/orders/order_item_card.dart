import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order_item.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem orderItem;

  const OrderItemCard(this.orderItem, {super.key});

  @override
  State<OrderItemCard> createState() => _OrderItemCartState();
}

class _OrderItemCartState extends State<OrderItemCard> {
  //var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildOrderSummary(),
          //if (_expanded) buildOrderDetails()
        ],
      ),
    );
  }

  Widget buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: min(widget.orderItem.productCount * 20.0 + 10, 100),
      child: ListView(
        children: widget.orderItem.products
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    prod.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${NumberFormat.decimalPattern().format(prod.price)} (${prod.quantity}kg) ',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildOrderSummary() {
    return ListTile(
      title: Text(
          '${NumberFormat.decimalPattern().format(widget.orderItem.amount)} Đồng'),
      subtitle: Text(
        DateFormat('hh:mm dd/MM/yyyy').format(widget.orderItem.dateTime),
      ),
      trailing: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                title: Column(
                  children: [
                    const Text('Chi tiết đơn hàng'),
                    Text(
                      'Ngày đặt: ${DateFormat('hh:mm dd/MM/yyyy').format(widget.orderItem.dateTime)}',
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: 'Tổng: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black)),
                        TextSpan(
                            text:
                                '${NumberFormat.decimalPattern().format(widget.orderItem.amount)} đồng',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blue,
                            ))
                      ]),
                    )
                  ],
                ),
                scrollable: true,
                actions: <Widget>[
                  TextButton(
                      child: const Text('Đóng'),
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      })
                ],
                content: SizedBox(
                  height: max(widget.orderItem.productCount * 20.0 + 10, 100),
                  width: double.infinity,
                  child: //Column(
                      //  children: const [
                      //Row(children: widget.orderItem.products
                      // .map(
                      //   (prod) => Row(
                      //     mainAxisAlignment:
                      //         MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Text(
                      //         prod.title,
                      //         style: const TextStyle(
                      //           fontSize: 15,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //       Text(
                      //         '${NumberFormat.decimalPattern().format(prod.price)} (${prod.quantity}kg) ',
                      //         style: const TextStyle(
                      //           fontSize: 15,
                      //           color: Colors.grey,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // )
                      // .toList(),
                      //)
                      Column(
                    children: widget.orderItem.products
                        .map(
                          (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${NumberFormat.decimalPattern().format(prod.price)} (${prod.quantity}kg) ',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )),
          );
        },
        child: const Text(
          'Chi tiết',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
