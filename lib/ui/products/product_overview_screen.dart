import 'package:flutter/material.dart';
import 'package:fruitshop/models/search_bar.dart';
import 'package:fruitshop/ui/products/products_manager.dart';
import 'package:provider/provider.dart';

import 'products_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  late Future<void> fetchProducts;

  @override
  void initState() {
    super.initState();
    fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const SizedBox(
          height: double.infinity,
          child: Image(
            image: NetworkImage(
                'https://t3.ftcdn.net/jpg/02/17/21/68/360_F_217216886_zmsKmNGEcGGs5cKgmL6vM6aCUfzY9OQy.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        toolbarHeight: 150,
        title: Column(
          children: [
            SizedBox(
                height: 100,
                width: double.infinity,
                child: Column(
                  children: const [
                    Text(
                      'FruitShop',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Hello Friends!',
                      style: TextStyle(
                          color: Color.fromARGB(255, 136, 136, 136),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            const SearchBar()
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: const ProductsGrid(false),
    );
  }
}
