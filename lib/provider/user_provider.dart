import 'package:flutter/material.dart';
import 'package:task_1_2/assortment/constants.dart';
import 'package:task_1_2/models/user_response_model.dart';
import 'package:task_1_2/network/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUser(String userId) async {
    // --- NEW: Validation Logic inside Provider ---
    // 1. Check for Empty Input
    if (userId.trim().isEmpty) {
      _errorMessage = StaticValues.userIdRequiredError;
      _user = null; // Clear previous user if any
      notifyListeners();
      return; // Stop here, do not call API
    }

    // 2. Check for Non-Numeric Input
    if (int.tryParse(userId.trim()) == null) {
      _errorMessage = StaticValues.invalidInputError;
      _user = null;
      notifyListeners();
      return; // Stop here, do not call API
    }
    // ---------------------------------------------

    _isLoading = true;
    _errorMessage = null;
    _user = null;
    notifyListeners();

    try {
      final UserResponseModel response = await _userService.fetchUserData(userId);

      if (response.success && response.user != null) {
        _user = response.user;
        _errorMessage = null;
      } else {
        _errorMessage = response.error ?? StaticValues.errorGeneric;
        _user = null;
      }
    } catch (e) {
      _errorMessage = StaticValues.errorGeneric;
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearProvider() {
    _user = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}