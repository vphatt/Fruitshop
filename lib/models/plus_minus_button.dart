import 'package:flutter/material.dart';
import 'package:fruitshop/ui/cart/cart_manager.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';

class PlusMinusButton extends StatelessWidget {
  const PlusMinusButton(
    this.cartItem,
    this.productId, {
    super.key,
  });

  final CartItem cartItem;
  final String productId;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final cart = context.read<CartManager>();
    return RichText(
      text: TextSpan(children: [
        WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: IconButton(
              icon: Icon(
                Icons.remove,
                size: height * 1 / 50,
              ),
              onPressed: () {
                if (cart.checkQuantity(productId) == true) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text('Xác Nhận:'),
                            content: const Text('Xoá khỏi Giỏ Hàng?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Không'),
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text('Có'),
                                onPressed: () {
                                  cart.removeSingleItem(productId);
                                  Navigator.of(ctx).pop(true);
                                },
                              ),
                            ],
                          ));
                } else {
                  cart.removeSingleItem(productId);
                }
              },
            )),
        TextSpan(
          text: '${cartItem.quantity}',
          style: TextStyle(color: Colors.black, fontSize: height * 1 / 50),
        ),
        WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: IconButton(
              icon: Icon(
                Icons.add,
                size: height * 1 / 50,
              ),
              onPressed: () {
                cart.addSingleItem(productId);
              },
            )),
        WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: const Text('Xác Nhận:'),
                          content: const Text('Xoá khỏi Giỏ Hàng?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Không'),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                            ),
                            TextButton(
                              child: const Text('Có'),
                              onPressed: () {
                                cart.removeItem(productId);
                                Navigator.of(ctx).pop(true);
                              },
                            ),
                          ],
                        ));
              },
            ))
      ]),
    );
  }
}
