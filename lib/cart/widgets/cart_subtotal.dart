import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatefulWidget {
  const CartSubtotal({super.key});

  @override
  State<CartSubtotal> createState() => _CartSubtotalState();
}

class _CartSubtotalState extends State<CartSubtotal> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = calculateSubtotal(user.cart);
    return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Text('Subtotal ', style: TextStyle(fontSize: 20)),
            Text(
              "\$$sum",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }

  int calculateSubtotal(List<dynamic> cart) {
    int sum = 0;
    cart.forEach((element) {
      sum += element['quantity'] * element['product']['price'] as int;
    });
    return sum;
  }
}
