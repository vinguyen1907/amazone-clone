import 'package:amazon_clone/constant/app_colors.dart';
import 'package:amazon_clone/features/home/services/home_service.dart';
import 'package:amazon_clone/features/home/widgets/deal_item.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/reusable_widgets/loader.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  const CategoryDealsScreen({super.key, required this.category});
  final String category;

  static const routeName = 'category_deals_screen';

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? products;
  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.appBarGradient,
              ),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: products == null
            ? const Loader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        alignment: Alignment.topLeft,
                        child: Text('Keep shopping for ${widget.category}',
                            style: const TextStyle(fontSize: 20))),
                    SizedBox(
                      height: 170,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        itemCount: products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                          // mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final product = products![index];
                          return DealItem(product: product);
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }

  void fetchCategoryProducts() async {
    products = await homeService.fetchCategoryProduct(
        context: context, category: widget.category);
    setState(() {});
  }
}
