import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/screens/home/component/box_item.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ListTile(
            leading: Text(
              'Saved Items',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 24),
            ),
            trailing: const Icon(Icons.notifications_none),
          ),
        ),
        body: SingleChildScrollView(child: Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, child) {
          return favoriteProvider.favoriteList!.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Icon(
                            Icons.favorite_outlined,
                            color: neutral500,
                            size: 64,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'No Saved Items',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'You dont have any saved items',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: neutral800),
                        ),
                        Text(
                          'Go to home and add some.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: neutral800),
                        )
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: Column(
                    children: [
                      Text('${favoriteProvider.favoriteList!.length} items'),
                      const SizedBox(
                        height: 16,
                      ),
                      GridView.count(
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 22,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        children: favoriteProvider.favoriteList!
                            .map((item) => BoxItem(item: item))
                            .toList(),
                      )
                    ],
                  ),
                );
        })));
  }
}
