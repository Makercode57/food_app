import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  QuantitySelector({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: Icon(Icons.remove), onPressed: onDecrease),
        Text('$quantity', style: TextStyle(fontSize: 18)),
        IconButton(icon: Icon(Icons.add), onPressed: onIncrease),
      ],
    );
  }
}