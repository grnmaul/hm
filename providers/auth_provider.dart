import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String email;
  final String name;
  final String? photoUrl;

  User({
    required this.email,
    required this.name,
    this.photoUrl,
  });
}

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  User? _user;

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    
    final name = email.split('@')[0];
    _user = User(
      email: email,
      name: name,
    );
    _isLoggedIn = true;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    await prefs.setString('userName', name);
    
    notifyListeners();
  }

  Future<void> signup(String email, String password, String name) async {
    await Future.delayed(const Duration(seconds: 2));
    
    _user = User(
      email: email,
      name: name,
    );
    _isLoggedIn = true;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    await prefs.setString('userName', name);
    
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _user = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    
    if (_isLoggedIn) {
      final email = prefs.getString('userEmail') ?? '';
      final name = prefs.getString('userName') ?? '';
      
      _user = User(
        email: email,
        name: name,
      );
    }
    
    notifyListeners();
  }
}
