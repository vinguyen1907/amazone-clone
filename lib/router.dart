import 'package:amazon_clone/cart/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSetting) {
  switch (routeSetting.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case SearchScreen.routeName:
      final query = routeSetting.arguments as String;
      return MaterialPageRoute(
          builder: (_) => SearchScreen(
                searchQuery: query,
              ));
    case CategoryDealsScreen.routeName:
      final category = routeSetting.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(category: category));
    case ProductDetailScreen.routeName:
      final product = routeSetting.arguments as Product;
      return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product));
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());
    case AddressScreen.routeName:
      final sum = routeSetting.arguments as int;
      return MaterialPageRoute(builder: (_) => AddressScreen(sum: sum));

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${routeSetting.name}'),
                ),
              ));
  }
}
