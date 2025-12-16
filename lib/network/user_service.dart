// lib/network/user_service.dart

import 'dart:convert';
import 'dart:io';

import 'package:task_1_2/models/user_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String? _baseUrl = dotenv.env['API_BASE_URL'];

  Future<UserResponseModel> fetchUserData(String userId) async {
    if (_baseUrl == null) {
      throw Exception('API_BASE_URL not found in .env file');
    }
    final String url = '$_baseUrl/users/$userId';

    try {
      final http.Response response = await http.get(Uri.parse(url));

      // --- FIX START ---
      // We accept 200 (OK)
      if (response.statusCode == 200) {
        // This will now correctly handle User 1 (success)
        // and User 2 (malformed data error).
        // It would ALSO handle User 3 if the API returned a 200 with error JSON.
        return UserResponseModel.fromJson(json.decode(response.body));
      } 
      // We ALSO specifically accept 404 (Not Found) as a valid case
      else if (response.statusCode == 404) {
        // This handles the server error you are seeing for User 3.
        // We manually create the error response that the provider expects.
        return UserResponseModel(success: false, error: 'No user found');
      }
      // --- FIX END ---
      
      else {
        // All other codes (like 500) are still server errors.
        throw Exception('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      rethrow;
    }
  }
}