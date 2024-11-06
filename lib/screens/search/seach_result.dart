import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/provider/item_provider.dart';
import 'package:ecommerce_app/screens/home/component/box_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeachResult extends StatelessWidget {
  const SeachResult({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemProvider>(context, listen: false).items!;
    List<Item> filterItems =
        items.where((item) => item.name.toLowerCase().contains(title)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style:
              Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          child: filterItems.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/no_result.png'),
                      const SizedBox(
                        height: 64,
                      ),
                      Text(
                        'No Result Found',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 24),
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    Text('${filterItems.length.toString()} items'),
                    const SizedBox(
                      height: 48,
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 24,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.65,
                      children: filterItems.map((item) {
                        return BoxItem(
                          item: item,
                        );
                      }).toList(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
