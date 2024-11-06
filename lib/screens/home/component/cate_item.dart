import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class CateItem extends StatelessWidget {
  const CateItem({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () =>
              Navigator.pushNamed(context, categoriesRoute, arguments: title),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: primary50),
            child: Icon(icon),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        )
      ],
    );
  }
}
