import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/utils/components/box_button.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class ModalDialog extends StatelessWidget {
  const ModalDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              size: 78,
              color: alert400,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text('Congratulations!'),
            const SizedBox(
              height: 8,
            ),
            const Text('Your order has been placed'),
            const SizedBox(
              height: 24,
            ),
            BoxButton(
                title: 'Track Your Order',
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context, orderRoute, (Route<dynamic> route) => false))
          ],
        ),
      ),
    );
  }
}
