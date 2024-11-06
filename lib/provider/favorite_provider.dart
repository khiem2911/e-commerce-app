import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Item> _favoriteList = [];

  List<Item>? get favoriteList => _favoriteList;

  Future<void> getFavoriteItem() async {
    final user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<dynamic> tempt = user.data()!['favoriteList'];
    List<Item> items = tempt.map((item) => Item.fromJson(item)).toList();
    _favoriteList = items;
    notifyListeners();
  }

  Map<String, dynamic> toMap(Item item) {
    return {
      'title': item.name,
      'price': item.price,
      'image': item.image,
      'description': item.description,
    };
  }

  Future<bool> onFavoriteItem(Item item, bool checked) async {
    List<Map<String, dynamic>> temptItem;

    if (checked) {
      _favoriteList = _favoriteList
          .where((favoriteItem) => favoriteItem.name != item.name)
          .toList();
      temptItem = _favoriteList.map((item) => toMap(item)).toList();
      await updateFavorite(temptItem);
      notifyListeners();
      return false;
    } else {
      _favoriteList.add(item);
    }
    temptItem = _favoriteList.map((item) => toMap(item)).toList();
    await updateFavorite(temptItem);
    notifyListeners();
    return true;
  }
}
