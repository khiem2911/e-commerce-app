import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:ecommerce_app/screens/cart/component/custom_bill.dart';
import 'package:ecommerce_app/screens/checkout/component/modal_dialog.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool isLoading = false;

  void _onPlaceOrder(CartProvider provider) async {
    setState(() {
      isLoading = true;
    });
    await provider.onCheckOut().then((_) {
      setState(() {
        isLoading = false;
      });
      showDialog(context: context, builder: (ctx) => const ModalDialog());
    });
  }

  @override
  Widget build(BuildContext context) {
    UserApp user = Provider.of<UserProvider>(context, listen: false).user!;
    final provider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          title: ListTile(
        trailing: const Icon(Icons.notifications_none_outlined),
        title: Center(
          child: Text(
            'Checkout',
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 24, color: neutral950),
          ),
        ),
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: neutral200, width: 1)),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Address',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: neutral950),
                  ),
                  Text('Change',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(decoration: TextDecoration.underline))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ListTile(
                leading: const Icon(
                  Icons.location_on_outlined,
                  size: 24,
                ),
                title: const Text('Home'),
                subtitle: Text(
                  user.location,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: neutral800),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: neutral200, width: 1)),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  Text(
                    'Payment Method',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: neutral950),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                        color: primary700,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: neutral200, width: 1)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Cash',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: neutral200, width: 1)),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Order Summary',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomBill(total: provider.totalCart),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: neutral950, width: 1),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.discount_outlined),
                          border: InputBorder.none,
                          hintText: 'Enter promo code'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primary700),
                    child: Text(
                      'Add',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : BoxButton(
                      title: 'Place Order',
                      onTap: () => _onPlaceOrder(provider))
            ],
          ),
        ),
      ),
    );
  }
}
