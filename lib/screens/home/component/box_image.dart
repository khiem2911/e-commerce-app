import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class BoxImage extends StatelessWidget {
  const BoxImage({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    bool? checkContain;

    void _onFavorite(FavoriteProvider favoriteProvider) async {
      bool checked = await favoriteProvider.onFavoriteItem(item, checkContain!);
      DelightToastBar(
              builder: (context) {
                return ToastCard(
                    leading: const Icon(
                      Icons.check_circle_rounded,
                      size: 32,
                    ),
                    title:
                        Text(checked ? 'Item Added To Saved' : 'Item Removed'));
              },
              autoDismiss: true,
              snackbarDuration: Durations.extralong4)
          .show(context);
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 160,
          child: Hero(
            tag: item.image,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(item.image),
            ),
          ),
        ),
        Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Consumer<FavoriteProvider>(
                builder: (context, favoriteProviders, child) {
                  checkContain = favoriteProviders.favoriteList!
                      .any((favoriteItem) => favoriteItem.name == item.name);
                  return InkWell(
                    onTap: () {
                      _onFavorite(favoriteProviders);
                    },
                    child: checkContain!
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border),
                  );
                },
              ),
            )),
      ],
    );
  }
}
