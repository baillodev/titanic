import 'package:flutter/material.dart';
import 'package:titanic_app/models/user_models.dart';
import 'package:titanic_app/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  BaseUser? _user;

  BaseUser? get user => _user;

  bool _isLoggedIn = false;
  bool _isLoading = true;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  AuthProvider(this._authService) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      final token = await _authService.getToken();
      
      if (token != null) {
        _isLoggedIn = true;
        _user = await _authService.fetchMe();
      } else {
        _isLoggedIn = false;
        _user = null;
      }

    } catch (e) {
      _isLoggedIn = false;
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(UserCredentials user) async {
    try {
      final result = await _authService.register(user);
      _user = BaseUser(username: result.username);
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(UserCredentials user) async {
    try {
      final result = await _authService.login(user);
      _user = BaseUser(username: result.username);
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}