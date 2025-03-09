import 'package:flutter/material.dart';

class ItemTableRow extends StatelessWidget {
  final Widget child;
  const ItemTableRow({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0), child: child);
  }
}
