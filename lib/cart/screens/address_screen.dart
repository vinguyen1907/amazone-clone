import 'package:amazon_clone/constant/app_colors.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/reusable_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  final int sum;
  const AddressScreen({super.key, required this.sum});

  static const routeName = 'address_screen';

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final GlobalKey _addressFormKey = GlobalKey<FormState>();

  List<PaymentItem> paymentItems = [];
  String addressToBeUsed = "";

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
      amount: widget.sum.toString(),
      label: 'Total Amount',
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.appBarGradient,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: flatBuildingController,
                    hintText: 'Flat, House no, Building',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: areaController,
                    hintText: 'Area, Street',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: pincodeController,
                    hintText: 'Pincode',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: cityController,
                    hintText: 'Town/City',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            ApplePayButton(
              width: double.infinity,
              style: ApplePayButtonStyle.whiteOutline,
              type: ApplePayButtonType.buy,
              paymentConfigurationAsset: 'applepay.json',
              onPaymentResult: onApplePayResult,
              paymentItems: paymentItems,
              margin: const EdgeInsets.only(top: 15),
              height: 50,
              onPressed: () => payPressed(address),
            ),
          ]),
        ));
  }

  payPressed(String addressFromProvider) {}

  void onApplePayResult(Map<String, dynamic> result) {}
}
