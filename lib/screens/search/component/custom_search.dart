import 'package:ecommerce_app/route/route_constant.dart';
import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch(
      {super.key, required this.onTap, required this.readOnly, this.autoFocus});
  final void Function() onTap;
  final bool readOnly;
  final FocusNode? autoFocus;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: onTap,
        child: TextField(
          onSubmitted: (value) => Navigator.of(context)
              .pushNamed(searchResultItemRoute, arguments: value),
          enabled: readOnly,
          focusNode: autoFocus,
          decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              hintText: 'Find your favorites items'),
        ),
      ),
    );
  }
}
