import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1_2/provider/name_provider.dart';

class NameDisplayWidget extends StatelessWidget {
  const NameDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Rule: Use Consumer where provider is used [cite: 422]
    return Consumer<NameProvider>(
      builder: (context, provider, child) {
        return Text(
          'Current Name: ${provider.userName}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}