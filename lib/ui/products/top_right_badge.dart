import 'package:flutter/material.dart';

class TopRightBadge extends StatelessWidget {
  const TopRightBadge({
    super.key,
    required this.child,
    required this.data,
    this.color,
  });

  final Widget child;
  final Object data;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: -3,
          top: -3,
          child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: color ?? Theme.of(context).colorScheme.secondary,
              ),
              constraints: BoxConstraints(
                minWidth: width * 1 / 25,
                minHeight: height * 1 / 50,
              ),
              child: Center(
                child: Text(
                  data.toString(),
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
        )
      ],
    );
  }
}
