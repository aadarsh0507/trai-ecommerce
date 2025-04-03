import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  bool get isAuth => _token != null;

  String? get token => _token;
  String? get userId => _userId;

  Future<void> signup(String email, String password) async {
    // TODO: Implement actual signup logic with your backend
    // For demo purposes, we'll just simulate a successful signup
    _token = 'demo_token';
    _userId = email;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // TODO: Implement actual login logic with your backend
    // For demo purposes, we'll just simulate a successful login
    _token = 'demo_token';
    _userId = email;
    notifyListeners();
  }

  void logout() {
    _token = null;
    _userId = null;
    notifyListeners();
  }
}