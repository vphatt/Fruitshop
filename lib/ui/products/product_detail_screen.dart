// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_new, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:fruitshop/ui/products/products_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../cart/cart_manager.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: Container(
          height: height * 1 / 10,
          padding: EdgeInsets.only(top: 20),
          child: Text(
            product.title,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        toolbarHeight: height * 1 / 12,
        actions: <Widget>[
          ValueListenableBuilder<bool>(
            valueListenable: product.isFavoriteListenable,
            builder: (ctx, isFavorite, child) {
              return Container(
                margin: EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 40,
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    ctx.read<ProductsManager>().toggleFavoriteStatus(product);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: 300,
                margin: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                decoration: BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MÔ TẢ SẢN PHẨM',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      product.description,
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FloatingActionButton.extended(
          elevation: 4.0,
          backgroundColor: Color(0xFFFF6A00),
          label: const Icon(
            Icons.add_shopping_cart,
            size: 40,
          ),
          onPressed: (() {
            final cart = context.read<CartManager>();
            if (cart.existProduct(product) == false) {
              cart.addItem(product);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                  padding: EdgeInsets.all(10),
                  content: Text(
                    "Đã thêm vào Giỏ Hàng",
                    style: TextStyle(fontSize: 20),
                  ),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "HUỶ BỎ",
                    onPressed: () {
                      cart.removeSingleItem(product.id!);
                    },
                  ),
                ));
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                  padding: EdgeInsets.all(10),
                  content: Text(
                    "Sản phẩm đã có trong Giỏ Hàng!",
                    style: TextStyle(fontSize: 20),
                  ),
                  duration: const Duration(seconds: 2),
                ));
            }
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.black87,
        child: new Container(
          height: height * 1 / 10,
          padding: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '${NumberFormat.decimalPattern().format(product.price)} ₫/kg',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: height * 1 / 40,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
