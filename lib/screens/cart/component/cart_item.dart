import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/screens/cart/component/custom_alert.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);

    Future<bool> _onDismissed() async {
      bool result = await showModalBottomSheet(
          isScrollControlled: true,
          useSafeArea: true,
          context: context,
          builder: (ctx) => CustomAlert(item: item));
      return result;
    }

    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        bool checked = await _onDismissed();

        if (checked) {
          provider.onRemoveItem(item);
          return checked;
        }
        return checked;
      },
      key: Key(item.name),
      background: Container(
          width: 10,
          height: 10,
          padding: const EdgeInsets.only(right: 21),
          color: alert100.withOpacity(0.2),
          child: const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete_forever_rounded,
                  color: alert200,
                )
              ])),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Image.network(
            item.image,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.name),
            const SizedBox(
              height: 4,
            ),
            const Text('size : XL'),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${item.price}'),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        provider.onTotalCart(item, false);
                      },
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: neutral200),
                        child: const Text(
                          '-',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(item.quantity.toString()),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () => {provider.onTotalCart(item, true)},
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: primary700),
                        child: const Text(
                          '+',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
