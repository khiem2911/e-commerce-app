import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  bool _authState = false;

  bool get auth => _authState;

  void changeAuth() {
    _authState = !_authState;
    notifyListeners();
  }
}
