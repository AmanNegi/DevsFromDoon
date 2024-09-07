import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/cache/app_cache.dart';
import 'package:lpu_events/models/app_state.dart';
import 'package:lpu_events/models/user.dart';

final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());

class AuthProvider extends ChangeNotifier {
  AppState _authState = AppState.initial();

  User? getCurrentUser() => _authState.user;
  bool isLoggedIn() => _authState.isLoggedIn;

  bool isManager() {
    return _authState.user == null ? false : _authState.user!.role == "manager";
  }

  bool isUser() {
    return _authState.user == null ? false : _authState.user!.role == "user";
  }

  updateUserData(User user) {
    _authState = AppState(
      isLoggedIn: true,
      user: user,
    );
    appCache.updateAppCache(_authState);
    notifyListeners();
  }

  clearUserData() {
    appCache.clearAppCache();
    notifyListeners();
  }
}
