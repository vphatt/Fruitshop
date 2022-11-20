import 'package:flutter/material.dart';
import 'product_grid_tile.dart';
import 'products_manager.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  const ProductsGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => showFavorites
            ? productsManager.favoriteItems
            : productsManager.items);

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGridTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}

class ProductsGridFavorites extends StatelessWidget {
  final bool showFavorites;
  const ProductsGridFavorites(
    this.showFavorites, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => showFavorites
            ? productsManager.favoriteItems
            : productsManager.items);
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: ((context, index) =>
          ProductGridTileFavorites(products[index])),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'product_grid_tile.dart';
// import 'products_manager.dart';
// import '../../models/product.dart';
// import 'package:provider/provider.dart';

// class ProductsGrid extends StatelessWidget {
//   final bool showFavorites;

//   const ProductsGrid(this.showFavorites, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     final products = context.select<ProductsManager, List<Product>>(
//       (productsManager) => showFavorites 
//         ? productsManager.favoriteItems 
//         : productsManager.items
//     );
    
//     return 
//          GridView.builder(
//           padding: const EdgeInsets.all(10.0),
//           itemCount: products.length,
//           itemBuilder: (ctx, i) => ProductGridTile(products[i]),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 1.5 / 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//         );
      
//   }
// }
 
