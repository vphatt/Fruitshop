import 'package:flutter/material.dart';
import 'package:fruitshop/models/plus_minus_button.dart';
import 'package:intl/intl.dart';
import '../../models/cart_item.dart';
import '../products/product_detail_screen.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final String productId;
  const CartItemCard({
    required this.cartItem,
    required this.productId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: width * 1 / 40,
        vertical: height * 1 / 100,
      ),
      child: Container(
          padding: const EdgeInsets.all(1),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: productId,
              );
            },
            child: ListTile(
              leading: SizedBox(
                width: 50,
                child: Image.network(
                  cartItem.imageUrl,
                ),
              ),
              title: Text(
                cartItem.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: width * 1 / 25, fontWeight: FontWeight.bold),
              ),
              subtitle: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Tổng: ${cartItem.quantity} kg \n = ',
                    style: TextStyle(
                        fontSize: width * 1 / 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        '${NumberFormat.decimalPattern().format(cartItem.price * cartItem.quantity)} Đồng',
                    style: TextStyle(
                        fontSize: width * 1 / 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(255, 32, 150, 36)),
                  ),
                ]),
              ),
              trailing: PlusMinusButton(cartItem, productId),
            ),
          )),
    );
  }
}
