import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_1_2/assortment/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticValues.appName),
        // MATCHED: Task 1 Style
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/task1'),
              child: const Text(StaticValues.task1Title),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.push('/task2'),
              child: const Text(StaticValues.task2Title),
            ),
          ],
        ),
      ),
    );
  }
}