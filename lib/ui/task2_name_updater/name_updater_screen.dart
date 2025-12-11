import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1_2/assortment/constants.dart';
import 'package:task_1_2/provider/name_provider.dart';
import 'package:task_1_2/ui/task2_name_updater/widgets/name_display_widget.dart';

class NameUpdaterScreen extends StatelessWidget {
  const NameUpdaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // UPDATED: Uses the new label 'Provider State'
        title: const Text(StaticValues.providerStateLabel),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NameDisplayWidget(), 
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<NameProvider>().updateName();
              },
              child: const Text(StaticValues.updateNameButton),
            ),
          ],
        ),
      ),
    );
  }
}