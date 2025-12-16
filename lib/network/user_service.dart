import 'dart:convert';
import 'dart:io';

import 'package:task_1_2/models/user_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  static final String? _baseUrl = dotenv.env['API_BASE_URL'];

  Future<UserResponseModel> fetchUserData(String userId) async {
    if (_baseUrl == null) throw Exception('API_BASE_URL not found');
    
    try {
      final http.Response response = await http.get(Uri.parse('$_baseUrl/users/$userId'));

      // OPTIMIZATION: Ternary Operator
      // Checks 200 first -> Checks 404 second -> Throws exception for anything else
      return response.statusCode == 200
          ? UserResponseModel.fromJson(json.decode(response.body))
          : response.statusCode == 404
              ? UserResponseModel.fromJson(json.decode(response.body))
              : throw Exception('Something went wrong');

    } on SocketException {
      throw Exception('Something went wrong');
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}