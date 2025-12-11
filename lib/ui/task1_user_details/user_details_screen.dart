import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    if (_formKey.currentState?.validate() ?? false) {
      final String userId = _userIdController.text.trim();
      FocusScope.of(context).unfocus();
      context.read<UserProvider>().fetchUser(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD), 
      appBar: AppBar(
        title: const Text(StaticValues.fetchUserLabel),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: null,
                  hintText: StaticValues.userIdHint,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                validator: RequiredValidator(errorText: StaticValues.userIdRequiredError).call,
              ),
            ),
            const SizedBox(height: 20.0),
            
            // Button (unchanged)
            Center(
              child: SizedBox(
                width: 120, 
                child: ElevatedButton(
                  onPressed: _fetchUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    StaticValues.fetchUserLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 30.0),

            Consumer<UserProvider>(
              builder: (BuildContext context, UserProvider provider, Widget? child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.errorMessage != null) {
                  return Center(
                    child: MessageDisplay(
                      message: provider.errorMessage!,
                      isError: true,
                    ),
                  );
                }

                if (provider.user != null) {
                  // --- NEW UPDATE: Constrain Max Width ---
                  // This centers the card and prevents it from growing wider than 900px
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: UserInfoCard(user: provider.user!),
                    ),
                  );
                  // ----------------------------------------
                }

                return const Center(
                  child: MessageDisplay(
                    message: StaticValues.initialMessage,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}