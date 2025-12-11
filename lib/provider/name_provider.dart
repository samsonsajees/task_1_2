import 'package:flutter/material.dart';

class NameProvider with ChangeNotifier {
  String _userName = 'christo';

  String get userName => _userName;

  void updateName() {
    _userName = 'Caddayn';
    notifyListeners();
  }

  void clearProvider() {
    _userName = 'christo';
    notifyListeners();
  }
}