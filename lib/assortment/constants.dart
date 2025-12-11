import 'package:flutter/material.dart';

class StaticValues {
  static const String appName = 'Caddayn Task';
  static const String task1Title = 'Task 1: API Fetch';
  static const String task2Title = 'Task 2: Provider State';
  
  // NEW: Added specific label as requested
  static const String providerStateLabel = 'Provider State'; 
  
  static const String fetchUserLabel = 'Fetch User';
  static const String userIdLabel = 'User ID';
  static const String updateNameButton = 'Update Name to "Caddayn"';
  
  static const String errorNoUser = 'No user found';
  static const String errorGeneric = 'Something went wrong';
  static const String initialMessage = 'Enter a user id and click button to get the user details';
}

class AppColors {
  static const Color cardBackground = Color(0xFF4CAF50); 
  static const Color textYellow = Color(0xFFFFEB3B);
  static const Color textWhite = Colors.white;
  static const Color textGreen = Colors.green; 
  
  static const Color errorText = Colors.red;
  static const Color textGrey = Colors.grey;
  static const Color buttonBlue = Colors.blue;
}