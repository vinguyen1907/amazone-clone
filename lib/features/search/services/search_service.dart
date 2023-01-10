import 'dart:convert';

import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:http/http.dart" as http;

class SearchService {
  Future<List<Product>> fetchSearchedProducts(
      {required BuildContext context, required String searchQuery}) async {
    final User user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];

    try {
      http.Response res = await http.get(
          Uri.parse("${GlobalVariables.uri}/api/products/search/$searchQuery"),
          headers: {
            'Context-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token,
          });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            for (var element in jsonDecode(res.body)) {
              products.add(Product.fromJson(jsonEncode(element)));
            }
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }

    return products;
  }
}
