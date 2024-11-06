import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/provider/item_provider.dart';
import 'package:ecommerce_app/screens/home/component/box_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    List<Item> itemsCategories =
        Provider.of<ItemProvider>(context, listen: false)
            .getItemCategories(title);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          title,
          style:
              Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text('${itemsCategories.length} items'),
              const SizedBox(
                height: 48,
              ),
              GridView.count(
                mainAxisSpacing: 24,
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 15,
                childAspectRatio: 0.65,
                children:
                    itemsCategories.map((item) => BoxItem(item: item)).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
