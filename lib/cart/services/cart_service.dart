import 'dart:convert';

import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartService {
  void removeFromCart(
      {required BuildContext context, required Product product}) async {
    final User user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response res = await http.delete(
        Uri.parse("${GlobalVariables.uri}/api/remove-from-cart/${product.id}"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            final User newUser =
                user.copyWith(cart: jsonDecode(res.body)["cart"]);
            Provider.of<UserProvider>(context, listen: false)
                .setUserFromModel(newUser);
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}
