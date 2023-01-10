import 'dart:convert';

import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<Product> fetchDealOfDay({required BuildContext context}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0,
        id: '');

    try {
      http.Response res = await http
          .get(Uri.parse("${GlobalVariables.uri}/api/deal-of-day"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.token,
      });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            product = Product.fromJson(res.body);
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }

    return product;
  }

  Future<List<Product>> fetchCategoryProduct(
      {required BuildContext context, required String category}) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];

    try {
      http.Response res = await http.get(
          Uri.parse("${GlobalVariables.uri}/api/products?category=$category"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
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
