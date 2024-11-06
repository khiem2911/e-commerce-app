import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/screens/home/component/box_image.dart';
import 'package:flutter/material.dart';

class BoxItem extends StatelessWidget {
  const BoxItem({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(detailRoute, arguments: item),
      child: Card(
          child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxImage(item: item),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('\$${item.price}')
                ],
              ))),
    );
  }
}
