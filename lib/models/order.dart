import 'dart:convert';

import 'package:amazon_clone/models/product.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Order {
  final String id;
  List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderAt;
  final int status;
  final double totalPrice;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderAt,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderAt': orderAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      products: List<Product>.from(
        (map['products'] as List<int>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      quantity: List<int>.from((map['quantity'] as List<int>)),
      address: map['address'] as String,
      userId: map['userId'] as String,
      orderAt: map['orderAt'] as int,
      status: map['status'] as int,
      totalPrice: map['totalPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
