import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class BoxButton extends StatelessWidget {
  const BoxButton({super.key, required this.title, required this.onTap});
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(top: 14),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: primary700),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ));
  }
}
