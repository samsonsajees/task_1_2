import 'package:flutter/material.dart';
import 'package:task_1_2/assortment/constants.dart';
import 'package:task_1_2/models/user_response_model.dart';
import 'package:task_1_2/network/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUser(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    _user = null;
    notifyListeners();

    try {
      final UserResponseModel response = await _userService.fetchUserData(userId);
      if (response.success && response.user != null) {
        _user = response.user;
      } else {
        _errorMessage = response.error ?? StaticValues.errorNoUser;
      }
    } catch (e) {
      debugPrint('Error: $e');
      _errorMessage = StaticValues.errorGeneric;
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