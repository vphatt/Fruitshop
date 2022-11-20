// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../cart/cart_manager.dart';
import 'product_detail_screen.dart';
import '../products/products_manager.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 5.0,
          offset: Offset(0, 1),
          spreadRadius: 0.8,
        )
      ]),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: GridTile(
              footer: buildGridFooterBar(context),
              child: GestureDetector(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    );
  }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            '${NumberFormat.decimalPattern().format(product.price)} ₫/kg',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Color(0xFF0B7E31),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          )
        ],
      ),
      trailing: ValueListenableBuilder<bool>(
        valueListenable: product.isFavoriteListenable,
        builder: (ctx, isFavorite, child) {
          return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              ctx.read<ProductsManager>().toggleFavoriteStatus(product);
            },
          );
        },
      ),
    );
  }
}

class ProductGridTileFavorites extends StatelessWidget {
  const ProductGridTileFavorites(
    this.product, {
    super.key,
  });

  final Product product;
  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartManager>();
    return Container(
      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
      decoration: BoxDecoration(color: Colors.white),
      child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          leading: SizedBox(
            width: 70,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(product.title),
          trailing: RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: ValueListenableBuilder<bool>(
                  valueListenable: product.isFavoriteListenable,
                  builder: (ctx, isFavorite, child) {
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        ctx
                            .read<ProductsManager>()
                            .toggleFavoriteStatus(product);
                      },
                    );
                  },
                ),
              ),
              WidgetSpan(
                  child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                ),
                onPressed: () {
                  if (cart.existProduct(product) == false) {
                    cart.addItem(product);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin:
                            EdgeInsets.only(bottom: 50, left: 20, right: 20),
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
                        margin:
                            EdgeInsets.only(bottom: 50, left: 20, right: 20),
                        padding: EdgeInsets.all(10),
                        content: Text(
                          "Sản phẩm đã có trong Giỏ Hàng!",
                          style: TextStyle(fontSize: 20),
                        ),
                        duration: const Duration(seconds: 2),
                      ));
                  }
                },
              ))
            ]),
          )),
    );
  }
}


// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/product.dart';
// import 'product_detail_screen.dart';
// import '../products/products_manager.dart';

// class ProductGridTile extends StatelessWidget {
//   const ProductGridTile(
//     this.product, {
//     super.key,
//   });

//   final Product product;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration:
//           BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
//         BoxShadow(
//           color: Colors.black38,
//           blurRadius: 5.0,
//           offset: Offset(0, 1),
//           spreadRadius: 0.8,
//         )
//       ]),
//       child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: InkWell(
//             onTap: () {
//               Navigator.of(context).pushNamed(
//                 ProductDetailScreen.routeName,
//                 arguments: product.id,
//               );
//             },
//             child: GridTile(
//               footer: buildGridFooterBar(context),
//               child: GestureDetector(
//                 child: Image.network(
//                   product.imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           )),
//     );
//   }

//   Widget buildGridFooterBar(BuildContext context) {
//     return GridTileBar(
//       backgroundColor: Color.fromARGB(255, 232, 232, 232),
//       title: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             product.title,
//             textAlign: TextAlign.start,
//             style: TextStyle(
//                 color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             '${product.price} ₫/kg',
//             textAlign: TextAlign.start,
//             style: TextStyle(
//                 color: Color(0xFF0B7E31),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18),
//           )
//         ],
//       ),
//       trailing: ValueListenableBuilder<bool>(
//         valueListenable: product.isFavoriteListenable,
//         builder: (ctx, isFavorite, child) {
//           return IconButton(
//             icon: Icon(
//               isFavorite ? Icons.favorite : Icons.favorite_border,
//             ),
//             color: Theme.of(context).colorScheme.secondary,
//             onPressed: () {
//               ctx.read<ProductsManager>().toggleFavoriteStatus(product);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
