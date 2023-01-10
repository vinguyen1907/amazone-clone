import 'dart:convert';

import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final User user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response res =
          await http.post(Uri.parse("${GlobalVariables.uri}/api/rate-product"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': user.token,
              },
              body: jsonEncode({'productId': product.id, 'rating': rating}));

      httpErrorHandler(response: res, context: context, onSuccess: () {});
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void addToCart(
      {required BuildContext context, required Product product}) async {
    final User user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response res =
          await http.post(Uri.parse("${GlobalVariables.uri}/api/add-to-cart"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': user.token,
              },
              body: product.toJson());

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            final User newUser =
                user.copyWith(cart: jsonDecode(res.body)["cart"]);
            Provider.of<UserProvider>(context, listen: false)
                .setUserFromModel(newUser);

            showSnackBar(context, "Added to your cart successfully!");
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}
