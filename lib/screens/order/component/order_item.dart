import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('size : XL'),
              Text(
                'Track Order',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: primary700),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${item.price}'),
            ],
          )
        ],
      ),
    );
  }
}
