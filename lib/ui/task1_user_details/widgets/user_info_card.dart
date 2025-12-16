import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_1_2/assortment/constants.dart';
import 'package:task_1_2/models/user_response_model.dart';

class UserInfoCard extends StatelessWidget {
  final UserModel user;

  const UserInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: AppColors.cardBackground, 
        borderRadius: BorderRadius.circular(20.0), 
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: <Widget>[
          // ---------------- IMAGE SECTION ----------------
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0), 
                child: FastCachedImage(
                  url: user.profileImage,
                  fit: BoxFit.cover, 
                  loadingBuilder: (context, progress) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  },
                  errorBuilder: (context, error, stack) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.person, size: 80, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),

          // ---------------- TEXT SECTION ----------------
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  // ✅ FIXED: Using specialized Widgets instead of functions
                  _UserInfoRow(label: 'Name', value: user.name),
                  _UserInfoRow(label: 'User ID', value: user.userId.toString()),
                  _UserInfoRow(label: 'Age', value: user.age?.toString() ?? ''),
                  _UserInfoRow(label: 'Profession', value: user.profession),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- NEW CLASS: Replaces the _buildRow function ---
// Satisfies Rule #8: Do not return Widgets from functions 
// Satisfies Rule #3: Keep widgets small and focused [cite: 52]
class _UserInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _UserInfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label Column
          SizedBox(
            width: 85,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontWeight: FontWeight.bold,
                fontSize: 15, 
              ),
            ),
          ),
          
          // Colon Column
          const Text(
            ':',
            style: TextStyle(
              color: AppColors.textWhite,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          // Tab Space
          const SizedBox(width: 20.0), 

          // Value Column
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textYellow,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}