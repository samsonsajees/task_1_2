import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_1_2/assortment/constants.dart';
import 'package:task_1_2/provider/user_provider.dart';
import 'package:task_1_2/ui/task1_user_details/widgets/message_display.dart';
import 'package:task_1_2/ui/task1_user_details/widgets/user_info_card.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController _userIdController;

  @override
  void initState() {
    super.initState();
    _userIdController = TextEditingController();
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  void _fetchUser() {
    final String userId = _userIdController.text.trim();
    FocusScope.of(context).unfocus();
    context.read<UserProvider>().fetchUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground, 
      appBar: AppBar(
        title: const Text(StaticValues.fetchUserLabel),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40.0), // Reverted
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              SizedBox(
                width: 800, // Reverted
                child: TextField(
                  controller: _userIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: null,
                    hintText: StaticValues.userIdHint,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)), // Reverted
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)), // Reverted
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20.0), // Reverted
              
              SizedBox(
                width: 120, // Reverted
                child: Consumer<UserProvider>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      onPressed: provider.isLoading ? null : _fetchUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonBlue,
                        foregroundColor: AppColors.textWhite,
                        disabledBackgroundColor: AppColors.disabledButton,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Reverted
                        ),
                      ),
                      child: const Text(
                        StaticValues.fetchUserLabel,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 30.0), // Reverted

              Consumer<UserProvider>(
                builder: (BuildContext context, UserProvider provider, Widget? child) {
                  if (provider.isLoading) {
                    return const CircularProgressIndicator();
                  }

                  if (provider.errorMessage != null) {
                    return MessageDisplay(
                      message: provider.errorMessage!,
                      isError: true,
                    );
                  }

                  if (provider.user != null) {
                    return SizedBox(
                      width: 800, // Reverted
                      child: UserInfoCard(user: provider.user!),
                    );
                  }

                  return const MessageDisplay(
                    message: StaticValues.initialMessage,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}