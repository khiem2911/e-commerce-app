import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/country.dart';
import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/provider/categories_provider.dart';
import 'package:ecommerce_app/provider/item_provider.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/utils/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/model/user.dart';
import 'package:provider/provider.dart';

Future<List<Country>> fetchCountries() async {
  final result =
      await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
  if (result.statusCode == 200) {
    List<dynamic> data = jsonDecode(result.body);
    return data.map((item) => Country.fromJson(item)).toList();
  }
  return [];
}

void getCurrentLocation(Function() isDone, BuildContext context) async {
  try {
    Position position = await Services().getCurrentLocation();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    String location = place.street! + ',' + place.country!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'location': location}).then((_) async {
      await getUser(context);
      Navigator.pushNamedAndRemoveUntil(
          context, tabsBottomRoute, (Route<dynamic> route) => false);
    });
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> getUser(BuildContext context) async {
  final user = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  UserApp userData = UserApp(
      email: user.data()!['email'] ?? FirebaseAuth.instance.currentUser!.email,
      location: user.data()!['location']);

  Provider.of<UserProvider>(context, listen: false).setUser(userData);
}

Future<void> getItems(BuildContext context) async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));

  final response2 =
      await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

  if (response.statusCode == 200 && response2.statusCode == 200) {
    List<dynamic> temptItems = jsonDecode(response.body);
    List<dynamic> temptCategories = jsonDecode(response2.body);
    List<Item> items = temptItems.map((item) => Item.fromJson(item)).toList();
    Provider.of<ItemProvider>(context, listen: false).setItems(items);
    Provider.of<CategoriesProvider>(context, listen: false)
        .setCategories(temptCategories);
  }
}

Future<void> updateFavorite(List<Map<String, dynamic>> temptItem) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'favoriteList': temptItem});
}

Future<List<Item>> fetchOrders() async {
  final res = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('carts')
      .get();
  List<Map<String, dynamic>> tempt = res.docs.map((doc) => doc.data()).toList();
  List<Item> orders = tempt.map((data) => Item.fromJson(data)).toList();
  return orders;
}
