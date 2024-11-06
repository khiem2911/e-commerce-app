import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/screens/cart/component/cart_item.dart';
import 'package:ecommerce_app/screens/cart/component/custom_bill.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<StatefulWidget> createState() {
    return CartState();
  }
}

class CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    List<Item> cartItems = provider.cartItems!;

    return Scaffold(
      appBar: AppBar(
          forceMaterialTransparency: true,
          title: ListTile(
            leading: Text(
              'My Cart',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: neutral950, fontSize: 24),
            ),
            trailing: const Icon(Icons.notifications_none_outlined),
          )),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_sharp,
                    size: 64,
                    color: neutral500,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Your Cart Is Empty!',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 20, color: neutral950),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'When you add products, they\'ll appear here',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.normal, color: neutral800),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
              child: Column(children: [
                SizedBox(
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CartItem(item: cartItems[index]),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: neutral200, width: 1)),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
                CustomBill(total: provider.totalCart),
                const SizedBox(
                  height: 44,
                ),
                BoxButton(
                    title: 'Go To Checkout',
                    onTap: () => Navigator.pushNamed(context, checkOutRoute))
              ]),
            ),
    );
  }
}
