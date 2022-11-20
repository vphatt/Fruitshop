import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50.0),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 50.0,
      ),
      // transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: Color.fromARGB(255, 125, 219, 42),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Color.fromARGB(103, 176, 59, 222),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: const Text(
        'Fruit Shop',
        style: TextStyle(
          color: Color.fromARGB(255, 127, 234, 168),
          fontSize: 50,
          fontFamily: 'Anton',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
