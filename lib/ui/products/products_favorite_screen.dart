// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'products_grid.dart';

class ProductsFavoriteScreen extends StatefulWidget {
  const ProductsFavoriteScreen({super.key});

  @override
  State<ProductsFavoriteScreen> createState() => _ProductsFavoriteScreenState();
}

class _ProductsFavoriteScreenState extends State<ProductsFavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  // Future<void> _refreshProducts(BuildContext context) async {
  //   await context.read<ProductsManager>().fetchProducts(true);
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(44, 0, 0, 0),
      appBar: AppBar(
        title: Text(
          "Sản Phẩm Yêu Thích",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: height * 1 / 15,
        centerTitle: false,
      ),
      body: ProductsGridFavorites(true),
    );
  }
}


// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';

// import 'products_grid.dart';

// class ProductsFavoriteScreen extends StatefulWidget {
//   const ProductsFavoriteScreen({super.key});

//   @override
//   State<ProductsFavoriteScreen> createState() => _ProductsFavoriteScreenState();
// }

// class _ProductsFavoriteScreenState extends State<ProductsFavoriteScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Sản Phẩm Yêu Thích",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           toolbarHeight: 100,
//           centerTitle: false,
//           elevation: 0,
//         ),
//         body: ProductsGrid(true));
//   }
// }


