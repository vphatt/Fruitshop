// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:fruitshop/ui/screens.dart';
import 'package:provider/provider.dart';

import 'user_product_list_tile.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'Quản lý sản phẩm',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            buildAddButton(context),
          ],
        ),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: buildUserProductListView(),
            );
          },
        ));
  }

  Widget buildUserProductListView() {
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          AddProductScreen.routeName,
        );
      },
      icon: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
