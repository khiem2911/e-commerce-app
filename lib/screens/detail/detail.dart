import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/screens/home/component/box_image.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    void _onAddToCart() {
      bool checked = cartProvider.onToogleItemToCart(item);
      DelightToastBar(
              builder: (context) {
                return ToastCard(
                    leading: const Icon(
                      Icons.check_circle_rounded,
                      size: 32,
                    ),
                    title: Text(
                        checked ? 'already in cart' : 'added item to cart'));
              },
              autoDismiss: true,
              snackbarDuration: Durations.extralong4)
          .show(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style:
              Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 260,
            child: BoxImage(item: item),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '\$${item.price}',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Product Details',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                ReadMoreText(
                  item.description,
                  trimMode: TrimMode.Line,
                  trimLines: 3,
                  colorClickableText: primary700,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primary700),
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
                  height: 48,
                ),
                BoxButton(title: 'Add To Cart', onTap: _onAddToCart)
              ],
            ),
          )
        ],
      ),
    );
  }
}
