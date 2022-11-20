// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fruitshop/main.dart';
import 'package:fruitshop/ui/orders/orders_screen.dart';
import '../auth/auth_manager.dart';
import 'user_products_screen.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color.fromARGB(44, 0, 0, 0),
        appBar: AppBar(
          title: Text(
            "Tài Khoản",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          toolbarHeight: height * 1 / 15,
          centerTitle: false,
        ),
        body: Column(children: [
          Container(
              height: 400,
              width: double.infinity,
              color: Color.fromARGB(255, 192, 192, 192),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 200,
                    color: Color.fromARGB(255, 91, 91, 91),
                  ),
                  Text(
                    '',
                    style: TextStyle(fontSize: 30),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )),
          Column(
            children: <Widget>[
              // const Divider(),
              // ListTile(
              //   leading: const Icon(Icons.payment),
              //   title: const Text('Lịch sử đặt hàng'),
              //   trailing: const Icon(Icons.keyboard_arrow_right),
              //   onTap: () {
              //     Navigator.of(context)
              //         .push(MaterialPageRoute(builder: (_) => OrdersScreen()));
              //   },
              // ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Quản lý sản phẩm'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => UserProductsScreen()));
                },
              ),
              const Divider(),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: const Text('Xác Nhận:'),
                              content:
                                  const Text('Bạn có chắc muốn đăng xuất?'),
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
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      Navigator.of(ctx).pop(true);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        context.read<AuthManager>().logout();

                                        return const MyApp();
                                      }));
                                    });
                                  },
                                ),
                              ],
                            ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: height * 1 / 15,
                    width: width * 1 / 2,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 171, 71, 64),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        )),
                        TextSpan(
                            text: '  Đăng xuất',
                            style: TextStyle(
                                fontSize: height * 1 / 40,
                                color: Colors.white)),
                      ]),
                    )),
                  )),
            ],
          ),
        ]));
  }
}
