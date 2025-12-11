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
      // Height maintained at 500 as requested
      height: 500,
      decoration: BoxDecoration(
        color: AppColors.cardBackground, // Green color from constants
        borderRadius: BorderRadius.circular(20.0), // Rounded corners for the green card
      ),
      // Padding between the green border and the content (Image/Text)
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Vertically center the content
        children: <Widget>[
          // ---------------- IMAGE SECTION (Left Half) ----------------
          Expanded(
            flex: 1,
            child: Padding(
              // Uniform padding around the image inside the border
              padding: const EdgeInsets.all(6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0), // Rounded corners for the image itself
                child: FastCachedImage(
                  url: user.profileImage,
                  fit: BoxFit.cover, // Ensures image fills the height/width without distortion
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

          // ---------------- TEXT SECTION (Right Half) ----------------
          Expanded(
            flex: 1,
            child: Padding(
              // Left padding ensures text doesn't touch the image
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Vertically centers the text block
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildRow('Name', user.name),
                  _buildRow('User ID', user.userId.toString()),
                  _buildRow('Age', user.age?.toString() ?? ''),
                  _buildRow('Profession', user.profession),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      // Vertical spacing between rows matches the screenshot airiness
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label Column (Fixed width ensures colons align)
          SizedBox(
            width: 85, // Precise width to accommodate "Profession"
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

          // Tab Space (The gap requested)
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