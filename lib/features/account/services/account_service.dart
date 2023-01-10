import 'dart:convert';

import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountService {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    List<Order> orderList = [];
    final User user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response res = await http
          .get(Uri.parse("${GlobalVariables.uri}/api/orders/me"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.token,
      });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            orderList = jsonDecode(res.body)
                .map((order) => Order.fromJson(order))
                .toList();
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
    return orderList;
  }

  void logOut({required BuildContext context}) async {
    try {
      // delete token saved in device storage
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("x-auth-token", "");

      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}
