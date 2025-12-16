// lib/models/user_response_model.dart

class UserResponseModel {
  final bool success;
  final UserModel? user;
  final String? error;

  UserResponseModel({
    required this.success,
    this.user,
    this.error,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    // --- FIX START ---
    // 1. Check for the 'error' field FIRST.
    // This correctly handles user ID which returns an error message.
    if (json['error'] != null) {
      return UserResponseModel(
        success: false,
        error: json['error'],
      );
    }

    // 2. If 'error' is null, THEN try to parse the user data.
    try {
      // This will work for user ID 1.
      return UserResponseModel(
        success: true,
        user: UserModel.fromJson(json['data']['user']),
      );
    } catch (e) {
      // This will fail for user ID 2 (malformed data), which is expected.
      // The provider will catch this and show "Something went wrong".
      throw const FormatException('User data is malformed when error is null.');
    }
  }
}

class UserModel {
  final int userId;
  final String name;
  final int? age;
  final String profession;
  final String profileImage;

  static const String _placeholderImage = 'https://via.placeholder.com/150/000000/FFFFFF/?text=No+Image';

  UserModel({
    required this.userId,
    required this.name,
    this.age,
    required this.profession,
    required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final String imageUrl = json['profile_image'] ?? '';
    return UserModel(
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      profession: json['profession'] ?? '',
      profileImage: imageUrl.isNotEmpty ? imageUrl : _placeholderImage,
    );
  }
}