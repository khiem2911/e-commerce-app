import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/provider/categories_provider.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/provider/item_provider.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/screens/home/component/ads_slider.dart';
import 'package:ecommerce_app/screens/home/component/box_item.dart';
import 'package:ecommerce_app/screens/home/component/cate_item.dart';
import 'package:ecommerce_app/screens/search/component/custom_search.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constant/constant.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    UserApp user = Provider.of<UserProvider>(context, listen: false).user!;
    List<Item> items = Provider.of<ItemProvider>(context, listen: false).items!;
    List<dynamic> categories =
        Provider.of<CategoriesProvider>(context, listen: false).categories!;
    List<Item> hotItems = items.sublist(0, 6);

    return Scaffold(
        appBar: AppBar(
            forceMaterialTransparency: true,
            title: ListTile(
              title: Text(
                'Location',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: neutral800),
              ),
              subtitle: Text(
                user.location,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: neutral950),
              ),
              trailing: const Icon(
                Icons.notifications_none_outlined,
                size: 24,
              ),
            )),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearch(
                  readOnly: false,
                  onTap: () =>
                      Navigator.of(context).pushNamed(searchItemRoute)),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18),
                  ),
                  Text(
                    'View All',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: neutral900),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final categoryItem = categories[index];
                      return Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: CateItem(
                              title: categoryItem,
                              icon: categoriesIcon[categoryItem]!));
                    }),
              ),
              const AdsSlider(),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Hot Deals',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, child) {
                return GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: 0.65,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  children:
                      hotItems.map((value) => BoxItem(item: value)).toList(),
                );
              })
            ],
          ),
        ));
  }
}
