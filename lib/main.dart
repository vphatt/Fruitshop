// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fruitshop/ui/cart/cart_manager.dart';

import 'package:provider/provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ui/screens.dart';
import '/ui/shared/bottom_nav_bar.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthManager(),
          ),
          ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
              create: (ctx) => ProductsManager(),
              update: (ctx, authManager, productsManager) {
                productsManager!.authToken = authManager.authToken;
                return productsManager;
              }),

          ChangeNotifierProxyProvider<AuthManager, OrdersManager>(
              create: (ctx) => OrdersManager(),
              update: (ctx, authManager, ordersManager) {
                ordersManager!.authToken = authManager.authToken;
                return ordersManager;
              }),
          ChangeNotifierProvider(
            create: (ctx) => CartManager(),
          ),
          // ChangeNotifierProvider(
          //   create: (ctx) => OrdersManager(),
          // ),
        ],
        child: Consumer<AuthManager>(
          builder: (ctx, authManager, child) {
            return MaterialApp(
              title: 'My Shop',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Lato',
                colorScheme: ColorScheme.light(
                  primary: Color.fromARGB(255, 133, 227, 130),
                ).copyWith(
                  secondary: Colors.deepOrange,
                ),
              ),
              home: authManager.isAuth
                  ? const BottomNavBar()
                  : FutureBuilder(
                      future: authManager.tryAutoLogin(),
                      builder: (ctx, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const AuthScreen();
                      },
                    ),
              onGenerateRoute: (settings) {
                if (settings.name == ProductDetailScreen.routeName) {
                  final productId = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return ProductDetailScreen(
                        ctx.read<ProductsManager>().findById(productId),
                      );
                    },
                  );
                }

                if (settings.name == EditProductScreen.routeName) {
                  final productId = settings.arguments as String?;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return EditProductScreen(
                        productId != null
                            ? ctx.read<ProductsManager>().findById(productId)
                            : null,
                      );
                    },
                  );
                }
                if (settings.name == AddProductScreen.routeName) {
                  final productId = settings.arguments as String?;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return AddProductScreen(
                        productId != null
                            ? ctx.read<ProductsManager>().findById(productId)
                            : null,
                      );
                    },
                  );
                }

                return null;
              },
            );
          },
        ));
  }
}
