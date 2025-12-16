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
    // 1. Check the explicit 'success' flag from the API
    if (json['success'] == false) {
      return UserResponseModel(
        success: false,
        // Use the actual error message from the API (e.g., "No user found")
        error: json['error'],
      );
    }

    // 2. If success is true, parse the user data
    // If data is malformed, this will throw an error, which the Service catches.
    return UserResponseModel(
      success: true,
      user: UserModel.fromJson(json['data']['user']),
    );
  }
}

class UserModel {
  final int userId;
  final String name;
  final int? age;
  final String profession;
  final String profileImage;

  static const String _placeholderImage = 
  'https://via.placeholder.com/150/000000/FFFFFF/?text=No+Image';

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