import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomBill extends StatelessWidget {
  const CustomBill({super.key, required this.total});
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text(
            'Sub-total',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: neutral900),
          ),
          trailing: Text('\$${total.toStringAsFixed(2)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: neutral950)),
        ),
        const SizedBox(
          height: 12,
        ),
        ListTile(
            leading: Text('Delivery Fee',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: neutral900)),
            trailing: Text('\$20',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: neutral950))),
        const SizedBox(
          height: 12,
        ),
        ListTile(
            leading: Text('Discount',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: neutral900)),
            trailing: Text('\$10',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: neutral950))),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                  color: neutral200, width: 1, style: BorderStyle.solid)),
        ),
        ListTile(
            leading: Text('Total',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: neutral900)),
            trailing: Text('\$${(total + 30).toStringAsFixed(2)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: neutral950))),
      ],
    );
  }
}
