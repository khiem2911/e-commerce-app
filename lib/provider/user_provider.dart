import 'package:ecommerce_app/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserApp? _user;

  UserApp? get user => _user;

  void setUser(UserApp user) {
    _user = user;
  }
}
