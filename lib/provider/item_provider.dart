import 'package:ecommerce_app/model/item.dart';
import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  List<Item>? _items;

  List<Item>? get items => _items;

  void setItems(List<Item> data) {
    _items = data;
  }

  List<Item> getItemCategories(String title) {
    List<Item> temptCategories =
        _items!.where((item) => item.category == title).toList();
    return temptCategories;
  }
}
