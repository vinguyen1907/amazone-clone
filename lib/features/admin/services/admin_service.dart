import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  Future<List<Product>> fetchAllProducts(
      {required BuildContext context}) async {
    List<Product> products = [];
    User user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response res = await http.get(
          Uri.parse("${GlobalVariables.uri}/admin/get-products"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token,
          });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              products.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }

    return products;
  }

  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    final User user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      final cloudinary = CloudinaryPublic('dn0z7utue', 'lxdclvqr');
      List<String> imageUrls = [];

      for (var image in images) {
        CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image.path, folder: name));
        imageUrls.add(response.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res =
          await http.post(Uri.parse("${GlobalVariables.uri}/admin/add-product"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': user.token,
              },
              body: product.toJson());

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(context);
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void deleteProduct(
      BuildContext context, String productId, VoidCallback onSuccess) async {
    final User user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response res = await http.post(
          Uri.parse(
            "${GlobalVariables.uri}/admin/delete-product",
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token,
          },
          body: jsonEncode({'id': productId}));

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}
