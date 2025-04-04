import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  bool get isAuth => _token != null;

  String? get token => _token;
  String? get userId => _userId;

  Future<void> signup(String email, String password) async {
    // Mock signup - always succeed for demo purposes
    _token = 'demo_token';
    _userId = email;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // Mock login with hardcoded credentials
    if (email == 'test@example.com' && password == 'password123') {
      _token = 'demo_token';
      _userId = email;
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  void logout() {
    _token = null;
    _userId = null;
    notifyListeners();
  }
}