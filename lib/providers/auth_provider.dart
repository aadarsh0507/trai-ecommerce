import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _profilePhoto;
  String? _address;
  String? _phone;

  bool get isAuth => _token != null;

  String? get token => _token;
  String? get userId => _userId;
  String? get profilePhoto => _profilePhoto;
  String? get address => _address;
  String? get phone => _phone;

  Future<void> signup(String email, String password) async {
    // Mock signup - always succeed for demo purposes
    _token = 'demo_token';
    _userId = email;
    _profilePhoto = '';
    _address = '';
    _phone = '';
    notifyListeners();
  }

  Future<void> updateProfile({String? profilePhoto, String? address, String? phone}) async {
    // Update profile information
    if (profilePhoto != null) _profilePhoto = profilePhoto;
    if (address != null) _address = address;
    if (phone != null) _phone = phone;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // Allow login with any credentials for demonstration purposes
    // This bypasses the need for frontend validation
    if (email.isNotEmpty) {
      _token = 'demo_token';
      _userId = email;
      _profilePhoto = '';
      _address = '';
      _phone = '';
      notifyListeners();
    } else {
      throw Exception('Email cannot be empty');
    }
  }

  void logout() {
    _token = null;
    _userId = null;
    _profilePhoto = null;
    _address = null;
    _phone = null;
    notifyListeners();
  }
}