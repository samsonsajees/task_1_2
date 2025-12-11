import 'package:flutter/material.dart';
import 'package:task_1_2/assortment/constants.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  final bool isError;

  const MessageDisplay({
    super.key,
    required this.message,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500, // Slightly bolder for better visibility
        // CHANGE: Use Green for non-error messages
        color: isError ? AppColors.errorText : AppColors.textGreen, 
      ),
    );
  }
}