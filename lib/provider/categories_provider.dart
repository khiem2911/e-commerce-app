import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  List<dynamic>? _categories;

  List<dynamic>? get categories => _categories;

  void setCategories(List<dynamic> data) {
    _categories = data;
  }
}
