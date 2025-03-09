import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  final Color color;
  const CustomIndicator({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
