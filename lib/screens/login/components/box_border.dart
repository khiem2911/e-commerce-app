import 'package:ecommerce_app/services/google.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class BoxBorderItem extends StatelessWidget {
  const BoxBorderItem({super.key, required this.title, required this.icon});
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Google().signInWithGoole(context),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: primary100,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(icon)),
            const SizedBox(
              width: 16,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
