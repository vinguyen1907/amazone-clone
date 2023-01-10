import 'dart:convert';

import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/reusable_widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res =
          await http.post(Uri.parse('${GlobalVariables.uri}/api/signup'),
              body: user.toJson(),
              headers: Map<String, String>.from({
                'Content-Type': 'application/json; charset=UTF-8',
              }));

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'User created successfully');
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void signInUser(
      {required BuildContext context,
      required String password,
      required String email}) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${GlobalVariables.uri}/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: Map<String, String>.from(
              {'Content-Type': 'application/json; charset=UTF-8'}));

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // retrieve user to provider
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            // save user token to shared preferences
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void getUserData({required BuildContext context}) async {
    try {
      // get token from device
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        prefs.setString("x-auth-token", "");
      }

      http.Response tokenRes = await http.post(
          Uri.parse("${GlobalVariables.uri}/tokenIsValid"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!,
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
            Uri.parse('${GlobalVariables.uri}/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token,
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}
