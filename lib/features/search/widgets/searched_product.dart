import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/reusable_widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constant/utils.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Image.network(
              product.images[0],
              fit: BoxFit.contain,
              height: 135,
              width: 135,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: 255,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.name,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                ),
                Container(
                  // width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Stars(
                    rating: calculateRating(product),
                  ),
                ),
                Container(
                  // width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('Eligible for FREE Shipping'),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: const Text(
                    'In Stock',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ],
        ));
  }

  double calculateRating(Product product) {
    double total = 0;
    if (product.ratings == null || product.ratings!.isEmpty) {
      return 0;
    }

    for (final element in product.ratings!) {
      total += element.rating;
    }
    return total / product.ratings!.length;
  }
}
